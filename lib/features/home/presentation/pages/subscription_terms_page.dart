import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';

class SubscriptionTermsPage extends StatelessWidget {
  const SubscriptionTermsPage({super.key});

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
          context.tr('subscription_terms'),
          style: const TextStyle(
            color: AppColors.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('subscription_terms_title'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tertiary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('last_updated'),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.nonary,
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: context.tr('subscription_plans'),
                content: context.tr('subscription_plans_content'),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: context.tr('billing'),
                content: context.tr('billing_content'),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: context.tr('cancellation'),
                content: context.tr('cancellation_content'),
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: context.tr('refund_policy'),
                content: context.tr('refund_policy_content'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.tertiary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.nonary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

