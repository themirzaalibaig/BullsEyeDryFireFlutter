import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';

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
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: AppConstants.splashDuration), () {
      AppLogger.info('Navigating to language: ${AppConstants.languageRoute}');

      // Use offAllNamed to clear the navigation stack and go to language selection
      // This removes all previous routes and navigates to the language route
      Get.offAllNamed(AppConstants.languageRoute);
      AppLogger.info('Navigation command executed');
    });
  }
}
