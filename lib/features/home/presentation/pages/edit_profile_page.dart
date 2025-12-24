import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../../core/utils/logger.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../../core/services/token_service.dart';
import '../../../../shared/widgets/auth_text_input.dart';
import '../../../../core/widgets/app_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  UserModel? _currentUser;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final isAuthenticated = await TokenService.to.isAuthenticated();
      if (isAuthenticated) {
        final user = await _authRepository.getCurrentUser();
        setState(() {
          _currentUser = user;
          _usernameController.text = user.username;
          _phoneController.text = user.phone ?? '';
          _emailController.text = user.email;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final updatedUser = await _authRepository.updateProfile(
        username: _usernameController.text.trim(),
        phone: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : null,
      );
      setState(() {
        _currentUser = updatedUser;
      });

      ErrorHandler.showSuccess(context.tr('profile_updated_successfully'));
      Get.back();
    } catch (e, stackTrace) {
      AppLogger.error('Update profile error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: context.tr('failed_to_update_profile'),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
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
          context.tr('edit_profile'),
          style: const TextStyle(
            color: AppColors.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // Profile Picture
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: AppColors.tertiary,
                                  backgroundImage:
                                      _currentUser?.profilePicture != null
                                      ? NetworkImage(
                                          _currentUser!.profilePicture!,
                                        )
                                      : null,
                                  child: _currentUser?.profilePicture == null
                                      ? Icon(
                                          Icons.person,
                                          size: 60,
                                          color: AppColors.quaternary,
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: AppColors.secondary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                      color: AppColors.quaternary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            // Username - AuthTextInput widget
                            AuthTextInput(
                              controller: _usernameController,
                              label: context.tr('username'),
                              hint: context.tr('enter_your_username'),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return context.tr('username_required');
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                            // Email (read-only) - AuthTextInput widget
                            AuthTextInput(
                              controller: _emailController,
                              label: context.tr('email_address'),
                              hint: context.tr('email_address'),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                            // Phone - AuthTextInput widget
                            AuthTextInput(
                              controller: _phoneController,
                              label: context.tr('phone_number'),
                              hint: context.tr('your_phone_number'),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                    // Save Button at Bottom
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: AppButton(
                        text: context.tr('save_changes').toUpperCase(),
                        onPressed: _isSaving ? null : _saveProfile,
                        isLoading: _isSaving,
                        variant: AppButtonVariant.default_,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
