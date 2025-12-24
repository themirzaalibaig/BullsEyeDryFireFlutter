import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/services/token_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    AppLogger.info('SplashController initialized');
  }

  @override
  void onReady() {
    super.onReady();
    AppLogger.info('SplashController ready, starting navigation timer');
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for splash duration
    await Future.delayed(const Duration(seconds: AppConstants.splashDuration));

    try {
      // Check if user is authenticated
      final isAuthenticated = await TokenService.to.isAuthenticated();

      if (isAuthenticated) {
        AppLogger.info('User is authenticated, navigating to home');
        // User is logged in, redirect to home
        Get.offAllNamed(AppConstants.homeRoute);
      } else {
        AppLogger.info('User is not authenticated, navigating to language selection');
        // User is not logged in, redirect to language selection
        Get.offAllNamed(AppConstants.languageRoute);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error checking authentication status', e, stackTrace);
      // On error, default to language selection
      Get.offAllNamed(AppConstants.languageRoute);
    }
  }
}
