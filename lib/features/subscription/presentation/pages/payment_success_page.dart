import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/pricing_controller.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final plan = arguments?['plan'] as SubscriptionPlan?;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 60,
                  color: AppColors.quaternary,
                ),
              ),
              const SizedBox(height: 32),
              // Success Title
              Text(
                'Payment Successful!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Success Message
              Text(
                'Your subscription has been activated successfully.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.tertiary.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              if (plan != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Plan: ${plan == SubscriptionPlan.monthly ? 'MONTHLY' : 'YEARLY'}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 48),
              // Continue Button
              AppButton(
                text: 'Continue'.toUpperCase(),
                onPressed: () {
                  Get.offAllNamed(AppConstants.homeRoute);
                },
                variant: AppButtonVariant.default_,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
