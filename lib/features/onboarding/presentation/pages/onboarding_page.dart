import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../shared/widgets/auth_appbar.dart';
import '../../../../shared/widgets/auth_separator.dart';
import '../../../../shared/widgets/auth_welcome.dart';
import '../../../../shared/widgets/google_buttton.dart';
import '../../../../core/services/google_auth_service.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final googleAuthService = GoogleAuthService.to;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const AuthAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const AuthWelcome(),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: controller.upgradeToPro,
                    child: Text(
                      context.tr('upgrade_to_pro'),
                      style: TextStyle(
                        color: AppColors.tertiary,
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Obx(
                    () => GoogleButton(
                      onPressed: googleAuthService.isLoading.value
                          ? null
                          : googleAuthService.signInWithGoogle,
                      isLoading: googleAuthService.isLoading.value,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const AuthSeparator(),
                  const SizedBox(height: 12),
                  AppButton(
                    text: context.tr('signup_with_email'),
                    onPressed: controller.signupWithEmail,
                    variant: AppButtonVariant.default_,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const AuthSeparator(),
                  Text(
                    context.tr('have_account'),
                    style: TextStyle(color: AppColors.tertiary, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: context.tr('login'),
                    onPressed: controller.login,
                    variant: AppButtonVariant.default_,
                  ),
                  TextButton(
                    onPressed: controller.forgotPassword,
                    child: Text(
                      context.tr('forgot_password'),
                      style: TextStyle(
                        color: AppColors.tertiary,
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
