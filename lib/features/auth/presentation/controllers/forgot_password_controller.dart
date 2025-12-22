import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';

class ForgotPasswordController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;

  // Form controller
  final TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    // dispose() is safe to call multiple times
    emailController.dispose();
    super.onClose();
  }

  // Send OTP for forgot password
  Future<void> sendForgotPasswordOtp() async {
    // Store email value immediately to avoid accessing disposed controller
    String emailText;
    try {
      emailText = emailController.text;
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
        Get.snackbar(
          'Error',
          'Please enter your email',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // TODO: Call API to send OTP
      AppLogger.info('OTP sent successfully');

      // Navigate to OTP verification
      Get.toNamed(
        AppConstants.otpVerificationRoute,
        arguments: {'email': emailText, 'type': 'forgot_password'},
      );
    } catch (e, stackTrace) {
      AppLogger.error('Send OTP error', e, stackTrace);
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
