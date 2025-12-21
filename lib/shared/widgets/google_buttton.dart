import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';

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
          foregroundColor: AppColors.quaternary,
          side: const BorderSide(color: AppColors.tertiary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google logo (simplified - using colored circles)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4285F4), // Blue
                    Color(0xFF34A853), // Green
                    Color(0xFFFBBC05), // Yellow
                    Color(0xFFEA4335), // Red
                  ],
                  stops: const [0.0, 0.33, 0.66, 1.0],
                ),
              ),
              child: Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    color: AppColors.quaternary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
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
