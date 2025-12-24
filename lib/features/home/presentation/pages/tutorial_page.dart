import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

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
          context.tr('tutorial'),
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
                context.tr('welcome_to_tutorial'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tertiary,
                ),
              ),
              const SizedBox(height: 24),
              _buildTutorialStep(
                context,
                step: 1,
                title: context.tr('step_1_title'),
                description: context.tr('step_1_description'),
                icon: Icons.account_circle,
              ),
              const SizedBox(height: 24),
              _buildTutorialStep(
                context,
                step: 2,
                title: context.tr('step_2_title'),
                description: context.tr('step_2_description'),
                icon: Icons.gps_fixed,
              ),
              const SizedBox(height: 24),
              _buildTutorialStep(
                context,
                step: 3,
                title: context.tr('step_3_title'),
                description: context.tr('step_3_description'),
                icon: Icons.bar_chart,
              ),
              const SizedBox(height: 24),
              _buildTutorialStep(
                context,
                step: 4,
                title: context.tr('step_4_title'),
                description: context.tr('step_4_description'),
                icon: Icons.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorialStep(
    BuildContext context, {
    required int step,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.quinary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.septenary),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: const TextStyle(
                  color: AppColors.quaternary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.secondary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.tertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.nonary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

