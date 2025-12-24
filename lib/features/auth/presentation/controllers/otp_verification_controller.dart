import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/error_handler.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/auth_response_model.dart';

class OTPVerificationController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Loading state
  final RxBool isOtpLoading = false.obs;
  final RxBool isResendingOtp = false.obs;

  // Form controller
  final TextEditingController otpController = TextEditingController();

  // Observable for OTP length to track completion
  final RxInt otpLength = 0.obs;

  // Email and type from arguments
  String? email;
  String? type;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    email = args?['email'] as String?;
    type = args?['type'] as String? ?? 'emailVerification';
    AppLogger.info(
      'OTP Verification initialized for email: $email, type: $type',
    );

    // Listen to OTP controller changes
    otpController.addListener(_onOtpChanged);
  }

  void _onOtpChanged() {
    try {
      otpLength.value = otpController.text.length;
    } catch (e) {
      // Controller might be disposed, ignore
    }
  }

  @override
  void onClose() {
    // Remove listener before disposing
    try {
      otpController.removeListener(_onOtpChanged);
    } catch (e) {
      // Ignore if already removed
    }
    // Dispose is safe to call multiple times
    otpController.dispose();
    super.onClose();
  }

  // Check if OTP is complete (6 digits)
  bool get isOtpComplete => otpLength.value == 6;

  // Verify OTP
  Future<void> verifyOtp() async {
    // Store OTP value immediately to avoid accessing disposed controller
    String otpText;
    try {
      otpText = otpController.text.trim();
    } catch (e) {
      // Controller was disposed, return early
      AppLogger.warning('OTP controller was disposed');
      return;
    }

    if (email == null || email!.isEmpty) {
      ErrorHandler.handleError('Email not found. Please try again.');
      return;
    }

    if (otpText.length != 6) {
      ErrorHandler.handleError('Please enter a valid 6-digit OTP');
      return;
    }

    try {
      isOtpLoading.value = true;
      AppLogger.info('Verifying OTP...');

      // Determine OTP type
      final String otpType = type == 'forgot_password'
          ? 'forgotPassword'
          : 'emailVerification';

      // Call OTP verification API
      final AuthResponseModel response = await _authRepository.verifyOtp(
        email: email!,
        otp: otpText,
        type: otpType,
      );

      if (response.success) {
        AppLogger.info('OTP verified successfully');

        if (type == 'emailVerification' || type == 'signup') {
          // Navigate to home after successful signup/verification
          Get.offAllNamed(AppConstants.homeRoute);
        } else if (type == 'forgot_password') {
          // Navigate to reset password
          Get.toNamed(
            AppConstants.resetPasswordRoute,
            arguments: {'email': email},
          );
        }
      } else {
        // Handle API response errors
        ErrorHandler.handleApiResponse(
          success: response.success,
          message: response.message,
          errors: response.errors?.map((e) => e.toJson()).toList(),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('OTP verification error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to verify OTP. Please try again.',
      );
    } finally {
      isOtpLoading.value = false;
    }
  }

  // Resend OTP
  Future<void> resendOtp() async {
    if (email == null || email!.isEmpty) {
      ErrorHandler.handleError('Email not found. Please try again.');
      return;
    }

    try {
      isResendingOtp.value = true;
      AppLogger.info('Resending OTP...');

      // Determine OTP type
      final String otpType = type == 'forgot_password'
          ? 'forgotPassword'
          : 'emailVerification';

      // Call API to resend OTP
      final AuthResponseModel response = await _authRepository.resendOtp(
        email: email!,
        type: otpType,
      );

      if (response.success) {
        ErrorHandler.showSuccess('A new OTP has been sent to your email');
        // Clear OTP input
        try {
          otpController.clear();
        } catch (e) {
          // Ignore if controller is disposed
        }
      } else {
        // Handle API response errors
        ErrorHandler.handleApiResponse(
          success: response.success,
          message: response.message,
          errors: response.errors?.map((e) => e.toJson()).toList(),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Resend OTP error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to resend OTP. Please try again.',
      );
    } finally {
      isResendingOtp.value = false;
    }
  }
}
