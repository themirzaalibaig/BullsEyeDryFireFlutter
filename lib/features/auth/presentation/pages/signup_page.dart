import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../shared/widgets/auth_appbar.dart';
import '../../../../shared/widgets/auth_welcome.dart';
import '../../../../shared/widgets/auth_separator.dart';
import '../../../../shared/widgets/google_buttton.dart';
import '../../../../core/services/google_auth_service.dart';
import '../../../../shared/widgets/auth_text_input.dart';
import '../../../../shared/widgets/auth_password_input.dart';
import '../../../../shared/widgets/auth_phone_input.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/signup_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      AuthTextInput(
                        label: context.tr('whats_your_name'),
                        hint: context.tr('full_name'),
                        controller: controller.nameController,
                        validator: (value) =>
                            Validators.required(value, 'Name'),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthTextInput(
                        label: context.tr('whats_your_email'),
                        hint: context.tr('email_address'),
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthPhoneInput(
                        label: context.tr('enter_your_phone_number'),
                        hint: context.tr('your_phone_number'),
                        phoneController: controller.phoneController,
                        countryCodeController: controller.countryCodeController,
                        validator: (value) => Validators.phone(value),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthPasswordInput(
                        label: context.tr('create_your_password'),
                        hint: context.tr('enter_your_password'),
                        controller: controller.passwordController,
                        validator: (value) =>
                            Validators.minLength(value, 6, 'Password'),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      AuthPasswordInput(
                        label: context.tr('confirm_your_password'),
                        hint: context.tr('confirm_your_password'),
                        controller: controller.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != controller.passwordController.text) {
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
                          text: context.tr('next').toUpperCase(),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          controller.signUp();
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
                      child: Obx(() {
                        final googleAuthService = GoogleAuthService.to;
                        return GoogleButton(
                          onPressed: googleAuthService.isLoading.value
                              ? null
                              : controller.signInWithGoogle,
                          isLoading: googleAuthService.isLoading.value,
                        );
                      }),
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
