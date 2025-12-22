import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/services/google_sign_in_service.dart';
import '../../../../core/utils/logger.dart';

class OnboardingController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> continueWithGoogle() async {
    try {
      isLoading.value = true;
      AppLogger.info('Initiating Google Sign-In...');

      final GoogleSignInAccount? account = await GoogleSignInService.signIn();

      if (account != null) {
        // Print all user data
        print('═══════════════════════════════════════════════════════');
        print('✅ Google Sign-In Successful!');
        print('═══════════════════════════════════════════════════════');
        print('👤 User ID: ${account.id}');
        print('📧 Email: ${account.email}');
        print('👤 Display Name: ${account.displayName ?? 'N/A'}');
        print('🖼️  Photo URL: ${account.photoUrl ?? 'N/A'}');
        print('═══════════════════════════════════════════════════════');

        // Also log using AppLogger
        AppLogger.info('User Data:');
        AppLogger.info('  - ID: ${account.id}');
        AppLogger.info('  - Email: ${account.email}');
        AppLogger.info('  - Display Name: ${account.displayName}');
        AppLogger.info('  - Photo URL: ${account.photoUrl}');

        // You can navigate to the next screen here
        // Get.offNamed('/home');
      } else {
        AppLogger.warning('User cancelled Google Sign-In');
        print('❌ Google Sign-In was cancelled by the user');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Google Sign-In error in controller', e, stackTrace);
      print('❌ Error during Google Sign-In: $e');
      
      // Show error message to user
      Get.snackbar(
        'Sign-In Error',
        'Failed to sign in with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
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

