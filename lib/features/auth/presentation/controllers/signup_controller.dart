import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/services/google_sign_in_service.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';

class SignupController extends GetxController {
  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
    // Defer state change to next frame to avoid build during frame error
    await Future.microtask(() {});

    try {
      isLoading.value = true;
      AppLogger.info('Starting sign up process...');

      // Validate form
      if (nameController.text.isEmpty) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Please enter your name',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (emailController.text.isEmpty) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Please enter your email',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (phoneController.text.isEmpty) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Please enter your phone number',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (passwordController.text.isEmpty ||
          passwordController.text.length < 6) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Password must be at least 6 characters',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        isLoading.value = false;
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
}

