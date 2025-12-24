import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/token_service.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../auth/data/models/user_model.dart';
import 'edit_profile_page.dart';
import 'convert_guest_page.dart';
import 'help_page.dart';
import 'privacy_policy_page.dart';
import 'change_language_page.dart';
import 'subscription_terms_page.dart';
import 'subscription_status_page.dart';
import 'tutorial_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthRepository _authRepository = AuthRepository();
  UserModel? _currentUser;
  bool _isLoading = true;
  bool _isGuest = false;

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
          _isGuest = user.userType == 'GUEST';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          context.tr('profile'),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Profile Picture and Info
                    _buildProfileHeader(),
                    const SizedBox(height: 32),
                    // Menu Items
                    _buildMenuItems(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile Picture
        GestureDetector(
          onTap: () {
            Get.to(() => const EditProfilePage());
          },
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.tertiary,
                backgroundImage: _currentUser?.profilePicture != null
                    ? NetworkImage(_currentUser!.profilePicture!)
                    : null,
                child: _currentUser?.profilePicture == null
                    ? Icon(Icons.person, size: 50, color: AppColors.tertiary)
                    : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Username
        Text(
          _currentUser?.username ?? context.tr('guest_user'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.tertiary,
          ),
        ),
        const SizedBox(height: 4),
        // Email
        if (_currentUser?.email != null)
          Text(
            _currentUser!.email,
            style: const TextStyle(fontSize: 14, color: AppColors.tertiary),
          ),
        // Guest Badge
        if (_isGuest) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.secondary),
            ),
            child: Text(
              context.tr('guest_user'),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        // Subscription Badge
        if (_currentUser?.isSubscribed == true) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.secondary),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 16, color: AppColors.secondary),
                const SizedBox(width: 4),
                Text(
                  context.tr('pro_member'),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        // Edit Profile
        _buildMenuItem(
          context,
          icon: Icons.edit,
          title: context.tr('edit_profile'),
          onTap: () {
            Get.to(() => const EditProfilePage());
          },
        ),
        // Convert Guest (if guest)
        if (_isGuest)
          _buildMenuItem(
            context,
            icon: Icons.person_add,
            title: context.tr('convert_to_registered'),
            subtitle: context.tr('create_account_to_save_data'),
            onTap: () {
              Get.to(() => const ConvertGuestPage());
            },
          ),
        // Subscription Status (if subscribed)
        if (_currentUser?.isSubscribed == true)
          _buildMenuItem(
            context,
            icon: Icons.star,
            title: context.tr('subscription_status'),
            subtitle: context.tr('view_your_subscription'),
            onTap: () {
              Get.to(() => const SubscriptionStatusPage());
            },
          ),
        // Help
        _buildMenuItem(
          context,
          icon: Icons.help_outline,
          title: context.tr('help'),
          onTap: () {
            Get.to(() => const HelpPage());
          },
        ),
        // Privacy Policy
        _buildMenuItem(
          context,
          icon: Icons.privacy_tip_outlined,
          title: context.tr('privacy_policy'),
          onTap: () {
            Get.to(() => const PrivacyPolicyPage());
          },
        ),
        // Change Language
        _buildMenuItem(
          context,
          icon: Icons.language,
          title: context.tr('change_language'),
          onTap: () {
            Get.to(() => const ChangeLanguagePage());
          },
        ),
        // Subscription Terms
        _buildMenuItem(
          context,
          icon: Icons.description_outlined,
          title: context.tr('subscription_terms'),
          onTap: () {
            Get.to(() => const SubscriptionTermsPage());
          },
        ),
        // Tutorial
        _buildMenuItem(
          context,
          icon: Icons.school_outlined,
          title: context.tr('tutorial'),
          onTap: () {
            Get.to(() => const TutorialPage());
          },
        ),
        const Divider(height: 32),
        // Logout
        _buildMenuItem(
          context,
          icon: Icons.logout,
          title: context.tr('logout'),
          titleColor: AppColors.secondary,
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: titleColor ?? AppColors.tertiary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: titleColor ?? AppColors.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.tertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.tertiary),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.quaternary,
        title: Text(
          context.tr('logout'),
          style: const TextStyle(color: AppColors.tertiary),
        ),
        content: Text(
          context.tr('logout_confirmation'),
          style: const TextStyle(color: AppColors.tertiary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('cancel')),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _handleLogout();
            },
            child: Text(
              context.tr('logout'),
              style: const TextStyle(color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      await _authRepository.logout();
      Get.offAllNamed(AppConstants.onboardingRoute);
    } catch (e) {
      // Even if logout fails, clear tokens and navigate
      await TokenService.to.clearTokens();
      Get.offAllNamed(AppConstants.onboardingRoute);
    }
  }
}
