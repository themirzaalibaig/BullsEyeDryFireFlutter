import 'package:bullseye_dryfire/shared/widgets/auth_welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../shared/widgets/auth_appbar.dart';
import '../../../../shared/widgets/otp_input.dart';
import '../controllers/otp_verification_controller.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OTPVerificationController>();
    final arguments = Get.arguments as Map<String, dynamic>?;
    final String email = arguments?['email'] ?? '';

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const AuthAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const AuthWelcome(isShowTitle: false),
              const SizedBox(height: 40),
              Text(
                context.tr('otp_verification'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                context
                    .tr('enter_otp_sent_to_email')
                    .replaceAll('{email}', email),
                style: TextStyle(fontSize: 16, color: AppColors.nonary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // OTP Input - removed onCompleted to prevent auto-verification
              OTPInput(
                controller: controller.otpController,
                onCompleted: null, // Don't auto-verify on completion
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: controller.isResendingOtp.value
                    ? null
                    : controller.resendOtp,
                child: Obx(
                  () => Text(
                    context.tr('resend_otp'),
                    style: TextStyle(
                      color: controller.isResendingOtp.value
                          ? AppColors.nonary
                          : AppColors.tertiary,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Obx(
                  () => AppButton(
                    text: context.tr('verify').toUpperCase(),
                    onPressed:
                        (controller.isOtpComplete &&
                            !controller.isOtpLoading.value)
                        ? () {
                            // Only verify when button is clicked
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              controller.verifyOtp();
                            });
                          }
                        : null,
                    isLoading: controller.isOtpLoading.value,
                    variant: AppButtonVariant.default_,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
