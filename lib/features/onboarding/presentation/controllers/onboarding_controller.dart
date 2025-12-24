import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/error_handler.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../auth/data/models/auth_response_model.dart';

class OnboardingController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

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

  Future<void> continueAsGuest() async {
    try {
      AppLogger.info('Continuing as guest...');

      // Call guest login API
      final AuthResponseModel response = await _authRepository.guestLogin();

      if (response.success && response.user != null) {
        AppLogger.info('Guest login successful');
        // Navigate to home
        Get.offAllNamed(AppConstants.homeRoute);
      } else {
        // Handle API response errors
        ErrorHandler.handleApiResponse(
          success: response.success,
          message: response.message,
          errors: response.errors?.map((e) => e.toJson()).toList(),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Guest login error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to continue as guest. Please try again.',
      );
    }
  }
}
