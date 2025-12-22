import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';

class OTPVerificationController extends GetxController {
  // Loading state
  final RxBool isOtpLoading = false.obs;

  // Form controller
  final TextEditingController otpController = TextEditingController();


  // Verify OTP
  Future<void> verifyOtp(String type) async {
    // Store OTP value immediately to avoid accessing disposed controller
    String otpText;
    try {
      otpText = otpController.text;
    } catch (e) {
      // Controller was disposed, return early
      AppLogger.warning('OTP controller was disposed');
      return;
    }

    try {
      isOtpLoading.value = true;
      AppLogger.info('Verifying OTP...');

      if (otpText.length != 6) {
        isOtpLoading.value = false;
        Get.snackbar(
          'Error',
          'Please enter a valid OTP',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // TODO: Call OTP verification API
      AppLogger.info('OTP verified successfully');

      if (type == 'signup') {
        // Navigate to home after successful signup
        Get.offAllNamed(AppConstants.homeRoute);
      } else if (type == 'forgot_password') {
        // Navigate to reset password
        Get.toNamed(AppConstants.resetPasswordRoute);
      }
    } catch (e, stackTrace) {
      AppLogger.error('OTP verification error', e, stackTrace);
      Get.snackbar(
        'Error',
        'Invalid OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isOtpLoading.value = false;
    }
  }

  // Resend OTP
  Future<void> resendOtp() async {
    try {
      AppLogger.info('Resending OTP...');
      // TODO: Call API to resend OTP
      Get.snackbar(
        'OTP Resent',
        'A new OTP has been sent to your email',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Resend OTP error', e, stackTrace);
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
