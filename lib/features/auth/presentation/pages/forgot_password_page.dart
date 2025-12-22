import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../shared/widgets/auth_appbar.dart';
import '../../../../shared/widgets/auth_welcome.dart';
import '../../../../shared/widgets/auth_text_input.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const AuthAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const AuthWelcome(isShowTitle: false),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      context.tr('forgot_password_title'),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.tr('forgot_password_description'),
                      style: TextStyle(fontSize: 16, color: AppColors.nonary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AuthTextInput(
                      label: context.tr('whats_your_email'),
                      hint: context.tr('email_address'),
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      text: context.tr('send_otp').toUpperCase(),
                      onPressed: () {
                        controller.sendForgotPasswordOtp();
                      },
                      isLoading: controller.isLoading.value,
                      variant: AppButtonVariant.default_,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
