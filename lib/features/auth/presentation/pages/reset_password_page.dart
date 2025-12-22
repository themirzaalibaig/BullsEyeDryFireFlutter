import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../shared/widgets/auth_appbar.dart';
import '../../../../shared/widgets/auth_welcome.dart';
import '../../../../shared/widgets/auth_password_input.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const AuthAppBar(),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const AuthWelcome(isShowTitle: false),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        context.tr('reset_password'),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.tr('reset_password_description'),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.nonary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      AuthPasswordInput(
                        label: context.tr('create_your_password'),
                        hint: context.tr('enter_your_password'),
                        controller: controller.resetPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthPasswordInput(
                        label: context.tr('confirm_your_password'),
                        hint: context.tr('confirm_your_password'),
                        controller: controller.confirmResetPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value !=
                              controller.resetPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Obx(
                        () => AppButton(
                          text: context.tr('reset_password').toUpperCase(),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          controller.resetPassword();
                                        });
                                  }
                                },
                          isLoading: controller.isLoading.value,
                          variant: AppButtonVariant.default_,
                        ),
                      ),
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
