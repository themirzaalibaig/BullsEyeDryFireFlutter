import 'package:dio/dio.dart' as dio;
import 'dio_client.dart';
import '../utils/logger.dart';

abstract class ApiService {
  final dio.Dio _httpClient = DioClient.instance;

  dio.Dio get httpClient => _httpClient;

  // GET request
  Future<dio.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    bool auth = false, // Default: no auth required
  }) async {
    try {
      final finalOptions = options ?? dio.Options();
      finalOptions.extra ??= {};
      finalOptions.extra!['auth'] = auth;

      final response = await _httpClient.get(
        path,
        queryParameters: queryParameters,
        options: finalOptions,
        cancelToken: cancelToken,
      );
      return response;
    } on dio.DioException catch (e) {
      AppLogger.error('GET request failed: $path', e);
      rethrow;
    }
  }

  // POST request
  Future<dio.Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    bool auth = false, // Default: no auth required
  }) async {
    try {
      final finalOptions = options ?? dio.Options();
      finalOptions.extra ??= {};
      finalOptions.extra!['auth'] = auth;

      final response = await _httpClient.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: finalOptions,
        cancelToken: cancelToken,
      );
      return response;
    } on dio.DioException catch (e) {
      AppLogger.error('POST request failed: $path', e);
      rethrow;
    }
  }

  // PUT request
  Future<dio.Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    bool auth = false, // Default: no auth required
  }) async {
    try {
      final finalOptions = options ?? dio.Options();
      finalOptions.extra ??= {};
      finalOptions.extra!['auth'] = auth;

      final response = await _httpClient.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: finalOptions,
        cancelToken: cancelToken,
      );
      return response;
    } on dio.DioException catch (e) {
      AppLogger.error('PUT request failed: $path', e);
      rethrow;
    }
  }

  // DELETE request
  Future<dio.Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    bool auth = false, // Default: no auth required
  }) async {
    try {
      final finalOptions = options ?? dio.Options();
      finalOptions.extra ??= {};
      finalOptions.extra!['auth'] = auth;

      final response = await _httpClient.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: finalOptions,
        cancelToken: cancelToken,
      );
      return response;
    } on dio.DioException catch (e) {
      AppLogger.error('DELETE request failed: $path', e);
      rethrow;
    }
  }
}
