import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/app_constants.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  void onPressed() {
    // TODO: Implement Google sign in
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () => onPressed(),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: AppColors.tertiary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppConstants.googleIconPath, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              context.tr('continue_with_google'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
