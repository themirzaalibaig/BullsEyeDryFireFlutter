import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/auth_response_model.dart';

class ResetPasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Loading state
  final RxBool isLoading = false.obs;

  // Form controllers
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController confirmResetPasswordController =
      TextEditingController();

  // Email from arguments
  String? email;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    email = args?['email'] as String?;
    AppLogger.info('Reset Password initialized for email: $email');
  }

  @override
  void onClose() {
    // Dispose is safe to call multiple times
    resetPasswordController.dispose();
    confirmResetPasswordController.dispose();
    super.onClose();
  }

  // Reset Password
  Future<void> resetPassword() async {
    // Defer state change to next frame to avoid build during frame error
    await Future.microtask(() {});

    if (email == null || email!.isEmpty) {
      ErrorHandler.handleError('Email not found. Please try again.');
      return;
    }

    try {
      isLoading.value = true;
      AppLogger.info('Resetting password...');

      if (resetPasswordController.text.isEmpty ||
          resetPasswordController.text.length < 8) {
        isLoading.value = false;
        ErrorHandler.handleError(
          'Password must be at least 8 characters',
          showSnackbar: true,
        );
        return;
      }
      if (resetPasswordController.text != confirmResetPasswordController.text) {
        isLoading.value = false;
        ErrorHandler.handleError('Passwords do not match', showSnackbar: true);
        return;
      }

      // Call reset password API
      final AuthResponseModel response = await _authRepository.resetPassword(
        email: email!,
        password: resetPasswordController.text,
      );

      if (response.success) {
        AppLogger.info('Password reset successful');
        // Navigate to login
        Get.offAllNamed(AppConstants.loginRoute);
        ErrorHandler.showSuccess(
          'Password reset successfully. Please login with your new password.',
        );
      } else {
        // Handle API response errors
        ErrorHandler.handleApiResponse(
          success: response.success,
          message: response.message,
          errors: response.errors?.map((e) => e.toJson()).toList(),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Reset password error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to reset password. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
