import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized - this triggers the binding
    Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at center
            Expanded(
              child: Center(
                child: Image.asset(
                  AppConstants.logoPath,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.center_focus_strong,
                      size: 150,
                      color: AppColors.tertiary,
                    );
                  },
                ),
              ),
            ),
            // Loading indicator at bottom center
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  const LoadingWidget(size: 30, color: AppColors.tertiary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
