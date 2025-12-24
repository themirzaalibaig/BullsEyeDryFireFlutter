import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/auth_response_model.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Loading state
  final RxBool isLoading = false.obs;

  // Form controller
  final TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    // Dispose is safe to call multiple times
    emailController.dispose();
    super.onClose();
  }

  // Send OTP for forgot password
  Future<void> sendForgotPasswordOtp() async {
    // Store email value immediately to avoid accessing disposed controller
    String emailText;
    try {
      emailText = emailController.text.trim();
    } catch (e) {
      // Controller was disposed, return early
      AppLogger.warning('Email controller was disposed');
      return;
    }

    // Defer state change to next frame to avoid build during frame error
    await Future.microtask(() {});

    try {
      isLoading.value = true;
      AppLogger.info('Sending forgot password OTP...');

      if (emailText.isEmpty) {
        isLoading.value = false;
        ErrorHandler.handleError('Please enter your email', showSnackbar: true);
        return;
      }

      // Call API to send OTP
      final AuthResponseModel response = await _authRepository.forgotPassword(
        email: emailText,
      );

      if (response.success) {
        AppLogger.info('OTP sent successfully');
        // Navigate to OTP verification
        Get.toNamed(
          AppConstants.otpVerificationRoute,
          arguments: {'email': emailText, 'type': 'forgot_password'},
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
      AppLogger.error('Send OTP error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to send OTP. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
