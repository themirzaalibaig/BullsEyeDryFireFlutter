import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../shared/widgets/auth_appbar.dart';
import '../../../../shared/widgets/auth_welcome.dart';
import '../../../../shared/widgets/auth_separator.dart';
import '../../../../shared/widgets/google_buttton.dart';
import '../../../../shared/widgets/auth_text_input.dart';
import '../../../../shared/widgets/auth_password_input.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
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
                      const SizedBox(height: 24),
                      AuthTextInput(
                        label: context.tr('whats_your_email'),
                        hint: context.tr('email_address'),
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthPasswordInput(
                        label: context.tr('enter_your_password'),
                        hint: context.tr('enter_your_password'),
                        controller: controller.passwordController,
                        validator: (value) =>
                            Validators.required(value, 'Password'),
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppConstants.forgotPasswordRoute);
                          },
                          child: Text(
                            context.tr('forgot_password'),
                            style: const TextStyle(
                              color: AppColors.tertiary,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
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
                          text: context.tr('login').toUpperCase(),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    // Use post-frame callback to avoid build during frame
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          controller.login();
                                        });
                                  }
                                },
                          isLoading: controller.isLoading.value,
                          variant: AppButtonVariant.default_,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: AuthSeparator(),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Obx(
                        () => GoogleButton(
                          onPressed: controller.isGoogleLoading.value
                              ? null
                              : controller.signInWithGoogle,
                          isLoading: controller.isGoogleLoading.value,
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
