import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/services/google_sign_in_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';

class AuthController extends GetxController {
  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxBool isOtpLoading = false.obs;

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController confirmResetPasswordController =
      TextEditingController();

  // Forgot password email
  String? forgotPasswordEmail;

  @override
  void onInit() {
    super.onInit();
    countryCodeController.text = '+1'; // Default to US
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    resetPasswordController.dispose();
    confirmResetPasswordController.dispose();
    super.onClose();
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      AppLogger.info('Initiating Google Sign-In...');

      final GoogleSignInAccount? account = await GoogleSignInService.signIn();

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

  // Sign Up
  Future<void> signUp() async {
    try {
      isLoading.value = true;
      AppLogger.info('Starting sign up process...');

      // Validate form
      if (nameController.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter your name',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (emailController.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter your email',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (phoneController.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter your phone number',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (passwordController.text.isEmpty ||
          passwordController.text.length < 6) {
        Get.snackbar(
          'Error',
          'Password must be at least 6 characters',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // TODO: Call signup API
      // For now, simulate sending OTP
      AppLogger.info('Sign up successful, sending OTP...');

      // Navigate to OTP verification
      Get.toNamed(
        AppConstants.otpVerificationRoute,
        arguments: {'email': emailController.text, 'type': 'signup'},
      );
    } catch (e, stackTrace) {
      AppLogger.error('Sign up error', e, stackTrace);
      Get.snackbar(
        'Error',
        'Failed to sign up. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String type) async {
    try {
      isOtpLoading.value = true;
      AppLogger.info('Verifying OTP...');

      if (otpController.text.length != 6) {
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

  // Login
  Future<void> login() async {
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

  // Forgot Password - Send OTP
  Future<void> sendForgotPasswordOtp() async {
    try {
      isLoading.value = true;
      AppLogger.info('Sending forgot password OTP...');

      if (emailController.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter your email',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // TODO: Call API to send OTP
      forgotPasswordEmail = emailController.text;
      AppLogger.info('OTP sent successfully');

      // Navigate to OTP verification
      Get.toNamed(
        AppConstants.otpVerificationRoute,
        arguments: {'email': emailController.text, 'type': 'forgot_password'},
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

  // Reset Password
  Future<void> resetPassword() async {
    try {
      isLoading.value = true;
      AppLogger.info('Resetting password...');

      if (resetPasswordController.text.isEmpty ||
          resetPasswordController.text.length < 6) {
        Get.snackbar(
          'Error',
          'Password must be at least 6 characters',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (resetPasswordController.text != confirmResetPasswordController.text) {
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
