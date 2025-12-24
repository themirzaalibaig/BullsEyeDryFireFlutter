import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
          context.tr('help'),
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
                context.tr('help_title'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tertiary,
                ),
              ),
              const SizedBox(height: 24),
              _buildHelpSection(
                context,
                title: context.tr('getting_started'),
                content: context.tr('getting_started_content'),
              ),
              const SizedBox(height: 24),
              _buildHelpSection(
                context,
                title: context.tr('training_guide'),
                content: context.tr('training_guide_content'),
              ),
              const SizedBox(height: 24),
              _buildHelpSection(
                context,
                title: context.tr('faq'),
                content: context.tr('faq_content'),
              ),
              const SizedBox(height: 24),
              _buildHelpSection(
                context,
                title: context.tr('contact_support'),
                content: context.tr('contact_support_content'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection(
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

