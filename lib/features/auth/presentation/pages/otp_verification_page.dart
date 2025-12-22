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
    final String type = arguments?['type'] ?? 'signup';

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
              OTPInput(
                controller: controller.otpController,
                onCompleted: (code) {
                  controller.verifyOtp(type);
                },
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  controller.resendOtp();
                },
                child: Text(
                  context.tr('resend_otp'),
                  style: const TextStyle(
                    color: AppColors.tertiary,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Obx(
                  () => AppButton(
                    text: context.tr('verify').toUpperCase(),
                    onPressed: controller.isOtpLoading.value
                        ? null
                        : () {
                            // Store OTP value before async operation
                            final otpLength =
                                controller.otpController.text.length;
                            if (otpLength == 6) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                controller.verifyOtp(type);
                              });
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please enter a valid OTP',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
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
