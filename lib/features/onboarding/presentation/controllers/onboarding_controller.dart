import 'package:get/get.dart';

class OnboardingController extends GetxController {
  void continueWithGoogle() {
    // Handle Google sign in
    // TODO: Implement Google authentication
  }

  void signupWithEmail() {
    // Navigate to signup screen
    // Get.toNamed('/signup');
  }

  void login() {
    // Navigate to login screen
    // Get.toNamed('/login');
  }

  void upgradeToPro() {
    // Navigate to upgrade screen
    // Get.toNamed('/upgrade');
  }

  void forgotPassword() {
    // Navigate to forgot password screen
    // Get.toNamed('/forgot-password');
  }

  void continueAsGuest() {
    // Continue as guest
    Get.offNamed('/home');
  }
}

