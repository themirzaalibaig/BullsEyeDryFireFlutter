import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/google_auth_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/auth_response_model.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Loading states
  final RxBool isLoading = false.obs;

  // Form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    // Dispose is safe to call multiple times
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Google Sign-In - Uses reusable service
  Future<void> signInWithGoogle() async {
    final googleAuthService = GoogleAuthService.to;
    await googleAuthService.signInWithGoogle();
  }

  // Login
  Future<void> login() async {
    // Defer state change to next frame to avoid build during frame error
    await Future.microtask(() {});

    try {
      isLoading.value = true;
      AppLogger.info('Starting login process...');

      if (emailController.text.trim().isEmpty) {
        isLoading.value = false;
        ErrorHandler.handleError('Please enter your email', showSnackbar: true);
        return;
      }
      if (passwordController.text.isEmpty) {
        isLoading.value = false;
        ErrorHandler.handleError(
          'Please enter your password',
          showSnackbar: true,
        );
        return;
      }

      // Call login API
      final AuthResponseModel response = await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.success && response.user != null) {
        AppLogger.info('Login successful');
        // Navigate to home after successful login
        Get.offAllNamed(AppConstants.homeRoute);
      } else {
        // Handle API response errors
        ErrorHandler.handleApiResponse(
          success: response.success,
          message: response.message,
          errors: response.errors?.map((e) => e.toJson()).toList(),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Login error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to login. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
