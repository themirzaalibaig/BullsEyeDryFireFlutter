import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/colors.dart';

class AuthWelcome extends StatelessWidget {
  final bool isShowTitle;
  const AuthWelcome({super.key, this.isShowTitle = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isShowTitle) ...[
          Text(
            context.tr('welcome_to'),
            style: const TextStyle(
              fontSize: 24,
              color: AppColors.tertiary,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
        Image.asset(
          AppConstants.logoPath,
          height: 180,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.center_focus_strong,
              size: 150,
              color: AppColors.tertiary,
            );
          },
        ),
      ],
    );
  }
}
