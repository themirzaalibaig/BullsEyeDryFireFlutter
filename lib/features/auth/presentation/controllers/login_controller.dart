import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/google_sign_in_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';

class LoginController extends GetxController {
  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;

  // Form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      AppLogger.info('Initiating Google Sign-In...');

      final account = await GoogleSignInService.signIn();

      if (account != null) {
        AppLogger.info('Google Sign-In successful');
        AppLogger.info('User ID: ${account.id}');
        AppLogger.info('Email: ${account.email}');

        // Navigate to home after successful sign-in
        Get.offAllNamed(AppConstants.homeRoute);
      } else {
        AppLogger.warning('User cancelled Google Sign-In');
        Get.snackbar(
          'Sign-In Cancelled',
          'Google Sign-In was cancelled',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Google Sign-In error', e, stackTrace);
      Get.snackbar(
        'Sign-In Error',
        'Failed to sign in with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }

  // Login
  Future<void> login() async {
    // Defer state change to next frame to avoid build during frame error
    await Future.microtask(() {});

    try {
      isLoading.value = true;
      AppLogger.info('Starting login process...');

      if (emailController.text.isEmpty) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Please enter your email',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (passwordController.text.isEmpty) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Please enter your password',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // TODO: Call login API
      AppLogger.info('Login successful');

      // Navigate to home after successful login
      Get.offAllNamed(AppConstants.homeRoute);
    } catch (e, stackTrace) {
      AppLogger.error('Login error', e, stackTrace);
      Get.snackbar(
        'Error',
        'Invalid email or password. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

