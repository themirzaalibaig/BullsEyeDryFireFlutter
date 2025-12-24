import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../constants/colors.dart';
import '../utils/logger.dart';
import '../network/exceptions.dart';

/// Global error handler utility for consistent error handling across the app
class ErrorHandler {
  ErrorHandler._();

  /// Handle and display errors consistently
  ///
  /// [error] - The error object (can be DioException, AppException, or any Exception)
  /// [defaultMessage] - Default message to show if error message cannot be extracted
  /// [showSnackbar] - Whether to show a snackbar (default: true)
  ///
  /// Returns the error message string
  static String handleError(
    dynamic error, {
    String? defaultMessage,
    bool showSnackbar = true,
  }) {
    String errorMessage =
        defaultMessage ?? 'An error occurred. Please try again.';

    try {
      if (error is dio.DioException) {
        errorMessage = _handleDioException(error);
      } else if (error is AppException) {
        errorMessage = error.message;
      } else if (error is Exception) {
        errorMessage = error.toString().replaceAll('Exception: ', '');
      } else if (error is String) {
        errorMessage = error;
      } else {
        errorMessage = error.toString();
      }

      // Clean up error message
      errorMessage = _cleanErrorMessage(errorMessage);

      // Log error
      AppLogger.error('Error handled', error);

      // Show snackbar if requested
      if (showSnackbar) {
        _showErrorSnackbar(errorMessage);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error in error handler', e, stackTrace);
      if (showSnackbar) {
        _showErrorSnackbar(errorMessage);
      }
    }

    return errorMessage;
  }

  /// Handle DioException specifically
  static String _handleDioException(dio.DioException e) {
    String errorMessage = 'An error occurred. Please try again.';

    // Handle response errors (server returned an error)
    if (e.response != null) {
      final responseData = e.response?.data;

      if (responseData is Map<String, dynamic>) {
        // Try to extract message from response
        errorMessage =
            responseData['message'] as String? ??
            responseData['error'] as String? ??
            'An error occurred. Please try again.';

        // Check for errors array (common in API responses)
        if (responseData['errors'] != null &&
            responseData['errors'] is List &&
            (responseData['errors'] as List).isNotEmpty) {
          final firstError = (responseData['errors'] as List).first;
          if (firstError is Map<String, dynamic> &&
              firstError['message'] != null) {
            errorMessage = firstError['message'] as String;
          }
        }
      } else if (responseData is String) {
        errorMessage = responseData;
      }
    } else {
      // Handle network errors (no response)
      switch (e.type) {
        case dio.DioExceptionType.connectionTimeout:
        case dio.DioExceptionType.sendTimeout:
        case dio.DioExceptionType.receiveTimeout:
          errorMessage =
              'Connection timeout. Please check your internet connection.';
          break;
        case dio.DioExceptionType.unknown:
          if (e.error?.toString().contains('SocketException') == true ||
              e.error?.toString().contains('Network') == true) {
            errorMessage = 'No internet connection. Please check your network.';
          } else {
            errorMessage = 'Network error. Please try again.';
          }
          break;
        case dio.DioExceptionType.cancel:
          errorMessage = 'Request was cancelled.';
          break;
        case dio.DioExceptionType.badCertificate:
          errorMessage = 'Certificate error. Please try again.';
          break;
        case dio.DioExceptionType.connectionError:
          errorMessage =
              'Connection error. Please check your internet connection.';
          break;
        default:
          errorMessage = 'Network error. Please try again.';
      }
    }

    return errorMessage;
  }

  /// Clean up error message (remove common prefixes, trim, etc.)
  static String _cleanErrorMessage(String message) {
    return message
        .replaceAll('Exception: ', '')
        .replaceAll('Error: ', '')
        .trim();
  }

  /// Show error snackbar
  static void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.secondary,
      colorText: AppColors.quaternary,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// Show success snackbar
  static void showSuccess(String message, {Duration? duration}) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.tertiary,
      colorText: AppColors.quaternary,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// Show info snackbar
  static void showInfo(String message, {Duration? duration}) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.tertiary,
      colorText: AppColors.quaternary,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// Handle API response errors (for AuthResponseModel and similar)
  ///
  /// [response] - Response model with success and errors fields
  /// [defaultMessage] - Default message if no error message found
  /// [showSnackbar] - Whether to show snackbar
  ///
  /// Returns error message or null if successful
  static String? handleApiResponse<T>({
    required bool success,
    String? message,
    List<dynamic>? errors,
    String? defaultMessage,
    bool showSnackbar = true,
  }) {
    if (success) {
      return null;
    }

    String errorMessage =
        defaultMessage ?? 'An error occurred. Please try again.';

    // Extract error message from errors array
    if (errors != null && errors.isNotEmpty) {
      final firstError = errors.first;
      if (firstError is Map<String, dynamic> && firstError['message'] != null) {
        errorMessage = firstError['message'] as String;
      } else if (firstError is String) {
        errorMessage = firstError;
      }
    } else if (message != null && message.isNotEmpty) {
      errorMessage = message;
    }

    errorMessage = _cleanErrorMessage(errorMessage);

    if (showSnackbar) {
      _showErrorSnackbar(errorMessage);
    }

    return errorMessage;
  }
}
