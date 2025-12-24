import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../utils/logger.dart';
import '../constants/app_constants.dart';
import '../services/token_service.dart';
import 'exceptions.dart';

class DioClient {
  DioClient._();

  static dio.Dio? _dio;

  static dio.Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static dio.Dio _createDio() {
    final dioInstance = dio.Dio(
      dio.BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: Duration(seconds: AppConstants.apiTimeout),
        receiveTimeout: Duration(seconds: AppConstants.apiTimeout),
        sendTimeout: Duration(seconds: AppConstants.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dioInstance.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(),
      ErrorInterceptor(),
    ]);

    return dioInstance;
  }

  // Update base URL dynamically
  static void updateBaseUrl(String baseUrl) {
    _dio?.options.baseUrl = baseUrl;
  }

  // Add auth token
  static void setAuthToken(String token) {
    _dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  // Remove auth token
  static void removeAuthToken() {
    _dio?.options.headers.remove('Authorization');
  }
}

// Logging Interceptor
class LoggingInterceptor extends dio.Interceptor {
  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    AppLogger.info('REQUEST[${options.method}] => PATH: ${options.path}');
    AppLogger.debug('Headers: ${options.headers}');
    AppLogger.debug('Data: ${options.data}');
    AppLogger.debug('QueryParameters: ${options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    AppLogger.info(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    AppLogger.debug('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    AppLogger.error(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      err,
      err.stackTrace,
    );
    super.onError(err, handler);
  }
}

// Auth Interceptor
class AuthInterceptor extends dio.Interceptor {
  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) async {
    // Check if auth is required (default: false)
    final requiresAuth = options.extra['auth'] as bool? ?? false;

    if (requiresAuth) {
      try {
        final tokenService = Get.find<TokenService>();
        final accessToken = await tokenService.getAccessToken();

        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
          AppLogger.debug('Auth token added to request: ${options.path}');
        } else {
          AppLogger.warning(
            'Auth required but no token found for: ${options.path}',
          );
        }
      } catch (e) {
        AppLogger.error('Failed to get access token', e);
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(
    dio.DioException err,
    dio.ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - try to refresh token
    if (err.response?.statusCode == 401) {
      final requiresAuth = err.requestOptions.extra['auth'] as bool? ?? false;

      if (requiresAuth) {
        try {
          final tokenService = Get.find<TokenService>();
          final refreshToken = await tokenService.getRefreshToken();

          if (refreshToken != null && refreshToken.isNotEmpty) {
            AppLogger.info('Access token expired, attempting refresh...');

            // Try to refresh the token
            final dioInstance = DioClient.instance;
            final refreshResponse = await dioInstance.post(
              '/auth/refresh-token',
              data: {'refreshToken': refreshToken},
              options: dio.Options(
                extra: {'auth': false}, // Refresh endpoint is public
              ),
            );

            if (refreshResponse.statusCode == 200) {
              final responseData = refreshResponse.data as Map<String, dynamic>;
              final tokenData =
                  responseData['data']?['token'] as Map<String, dynamic>?;

              if (tokenData != null) {
                final newAccessToken = tokenData['accessToken'] as String;
                final newRefreshToken = tokenData['refreshToken'] as String;

                // Save new tokens
                await tokenService.saveTokens(newAccessToken, newRefreshToken);

                // Retry the original request with new token
                err.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                AppLogger.info('Token refreshed, retrying original request');

                try {
                  final response = await dioInstance.fetch(err.requestOptions);
                  return handler.resolve(response);
                } catch (e) {
                  return handler.reject(err);
                }
              }
            }
          }

          // Refresh failed or no refresh token - clear tokens and reject
          AppLogger.warning('Token refresh failed, clearing tokens');
          await tokenService.clearTokens();
        } catch (e, stackTrace) {
          AppLogger.error('Token refresh error', e, stackTrace);
          final tokenService = Get.find<TokenService>();
          await tokenService.clearTokens();
        }
      }
    }

    super.onError(err, handler);
  }
}

// Error Interceptor
class ErrorInterceptor extends dio.Interceptor {
  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    switch (err.type) {
      case dio.DioExceptionType.connectionTimeout:
      case dio.DioExceptionType.sendTimeout:
      case dio.DioExceptionType.receiveTimeout:
        handler.reject(
          err.copyWith(
            error: NetworkException(
              'Connection timeout. Please check your internet connection.',
            ),
          ),
        );
        return;
      case dio.DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data?['message'] ?? 'An error occurred';
        handler.reject(
          err.copyWith(
            error: ServerException(message: message, statusCode: statusCode),
          ),
        );
        return;
      case dio.DioExceptionType.cancel:
        handler.reject(
          err.copyWith(error: CancelException('Request was cancelled')),
        );
        return;
      case dio.DioExceptionType.unknown:
        if (err.error.toString().contains('SocketException')) {
          handler.reject(
            err.copyWith(error: NetworkException('No internet connection')),
          );
          return;
        }
        handler.reject(
          err.copyWith(
            error: UnknownException(
              err.error?.toString() ?? 'Unknown error occurred',
            ),
          ),
        );
        return;
      default:
        handler.reject(
          err.copyWith(error: UnknownException('An unexpected error occurred')),
        );
    }
  }
}
