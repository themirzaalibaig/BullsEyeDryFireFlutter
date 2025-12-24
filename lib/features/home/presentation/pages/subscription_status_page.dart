import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/token_service.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../auth/data/models/user_model.dart';

class SubscriptionStatusPage extends StatefulWidget {
  const SubscriptionStatusPage({super.key});

  @override
  State<SubscriptionStatusPage> createState() => _SubscriptionStatusPageState();
}

class _SubscriptionStatusPageState extends State<SubscriptionStatusPage> {
  final AuthRepository _authRepository = AuthRepository();
  UserModel? _currentUser;
  bool _isLoading = true;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.tertiary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.tr('subscription_status'),
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
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Subscription Status Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: _currentUser?.isSubscribed == true
                            ? AppColors.secondary.withValues(alpha: 0.1)
                            : AppColors.quinary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _currentUser?.isSubscribed == true
                              ? AppColors.secondary
                              : AppColors.septenary,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _currentUser?.isSubscribed == true
                                ? Icons.star
                                : Icons.star_border,
                            size: 48,
                            color: _currentUser?.isSubscribed == true
                                ? AppColors.secondary
                                : AppColors.nonary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _currentUser?.isSubscribed == true
                                ? context.tr('active_subscription')
                                : context.tr('no_active_subscription'),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _currentUser?.isSubscribed == true
                                  ? AppColors.secondary
                                  : AppColors.tertiary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _currentUser?.isSubscribed == true
                                ? context.tr('subscription_active_description')
                                : context.tr('upgrade_to_pro_description'),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.nonary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_currentUser?.isSubscribed != true)
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppConstants.subscriptionRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: AppColors.quaternary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          context.tr('upgrade_to_pro').toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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

