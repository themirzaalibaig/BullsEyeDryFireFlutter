import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/google_auth_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/auth_response_model.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Loading states
  final RxBool isLoading = false.obs;

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    countryCodeController.text = '+1'; // Default to US
  }

  @override
  void onClose() {
    // Dispose is safe to call multiple times
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Google Sign-In - Uses reusable service
  Future<void> signInWithGoogle() async {
    final googleAuthService = GoogleAuthService.to;
    await googleAuthService.signInWithGoogle();
  }

  // Sign Up
  Future<void> signUp() async {
    // Defer state change to next frame to avoid build during frame error
    await Future.microtask(() {});

    try {
      isLoading.value = true;
      AppLogger.info('Starting sign up process...');

      // Validate form
      if (nameController.text.trim().isEmpty) {
        isLoading.value = false;
        ErrorHandler.handleError('Please enter your name', showSnackbar: true);
        return;
      }
      if (emailController.text.trim().isEmpty) {
        isLoading.value = false;
        ErrorHandler.handleError('Please enter your email', showSnackbar: true);
        return;
      }
      if (phoneController.text.trim().isEmpty) {
        isLoading.value = false;
        ErrorHandler.handleError(
          'Please enter your phone number',
          showSnackbar: true,
        );
        return;
      }
      if (passwordController.text.isEmpty ||
          passwordController.text.length < 8) {
        isLoading.value = false;
        ErrorHandler.handleError(
          'Password must be at least 8 characters',
          showSnackbar: true,
        );
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        isLoading.value = false;
        ErrorHandler.handleError('Passwords do not match', showSnackbar: true);
        return;
      }

      // Build phone number with country code
      final String fullPhone =
          '${countryCodeController.text}${phoneController.text.trim()}';

      // Call signup API
      final AuthResponseModel response = await _authRepository.signup(
        username: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        phone: fullPhone,
      );

      if (response.success) {
        AppLogger.info('Sign up successful, navigating to OTP verification...');
        // Navigate to OTP verification
        Get.toNamed(
          AppConstants.otpVerificationRoute,
          arguments: {
            'email': emailController.text.trim(),
            'type': 'emailVerification',
          },
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
      AppLogger.error('Sign up error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to sign up. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
