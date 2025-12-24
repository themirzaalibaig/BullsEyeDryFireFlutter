import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/utils/logger.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../../shared/widgets/auth_text_input.dart';
import '../../../../shared/widgets/auth_password_input.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/utils/validators.dart';

class ConvertGuestPage extends StatefulWidget {
  const ConvertGuestPage({super.key});

  @override
  State<ConvertGuestPage> createState() => _ConvertGuestPageState();
}

class _ConvertGuestPageState extends State<ConvertGuestPage> {
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _convertToRegistered() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authRepository.convertGuestToRegistered(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        username: _usernameController.text.trim().isNotEmpty
            ? _usernameController.text.trim()
            : null,
      );

      if (response.success && response.user != null) {
        ErrorHandler.showSuccess(
          context.tr('account_created_successfully'),
        );
        Get.offAllNamed(AppConstants.homeRoute);
      } else {
        ErrorHandler.handleApiResponse(
          success: response.success,
          message: response.message,
          errors: response.errors?.map((e) => e.toJson()).toList(),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Convert guest error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: context.tr('failed_to_convert_account'),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.tertiary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          context.tr('convert_to_registered'),
          style: const TextStyle(
            color: AppColors.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Text(
                  context.tr('convert_guest_description'),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.nonary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AuthTextInput(
                  label: context.tr('username'),
                  hint: context.tr('enter_username'),
                  controller: _usernameController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                AuthTextInput(
                  label: context.tr('email'),
                  hint: context.tr('enter_email'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                AuthPasswordInput(
                  label: context.tr('password'),
                  hint: context.tr('enter_password'),
                  controller: _passwordController,
                  validator: (value) =>
                      Validators.minLength(value, 8, context.tr('password')),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                AuthPasswordInput(
                  label: context.tr('confirm_password'),
                  hint: context.tr('confirm_password'),
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.tr('please_confirm_password');
                    }
                    if (value != _passwordController.text) {
                      return context.tr('passwords_do_not_match');
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: context.tr('create_account').toUpperCase(),
                  onPressed: _isLoading ? null : _convertToRegistered,
                  isLoading: _isLoading,
                  variant: AppButtonVariant.default_,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

