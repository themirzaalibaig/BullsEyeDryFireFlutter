import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';

class ResetPasswordController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;

  // Form controllers
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController confirmResetPasswordController =
      TextEditingController();

  @override
  void onClose() {
    resetPasswordController.dispose();
    confirmResetPasswordController.dispose();
    super.onClose();
  }

  // Reset Password
  Future<void> resetPassword() async {
    // Defer state change to next frame to avoid build during frame error
    await Future.microtask(() {});

    try {
      isLoading.value = true;
      AppLogger.info('Resetting password...');

      if (resetPasswordController.text.isEmpty ||
          resetPasswordController.text.length < 6) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Password must be at least 6 characters',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (resetPasswordController.text != confirmResetPasswordController.text) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Passwords do not match',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // TODO: Call reset password API
      AppLogger.info('Password reset successful');

      // Navigate to login
      Get.offAllNamed(AppConstants.loginRoute);
      Get.snackbar(
        'Success',
        'Password reset successfully. Please login with your new password.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Reset password error', e, stackTrace);
      Get.snackbar(
        'Error',
        'Failed to reset password. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

