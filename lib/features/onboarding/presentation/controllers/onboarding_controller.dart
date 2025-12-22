import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';

class OnboardingController extends GetxController {
  void signupWithEmail() {
    Get.toNamed(AppConstants.signupRoute);
  }

  void login() {
    Get.toNamed(AppConstants.loginRoute);
  }

  void upgradeToPro() {
    Get.toNamed(AppConstants.subscriptionRoute);
  }

  void forgotPassword() {
    Get.toNamed(AppConstants.forgotPasswordRoute);
  }

  void continueAsGuest() {
    // Continue as guest
    Get.offNamed(AppConstants.homeRoute);
  }
}

