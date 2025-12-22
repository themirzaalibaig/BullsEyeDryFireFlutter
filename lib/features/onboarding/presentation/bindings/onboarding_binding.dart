import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';
import '../../../auth/presentation/bindings/signup_binding.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingController>(OnboardingController(), permanent: false);
    // Initialize SignupController for GoogleButton (can be used for Google Sign-In)
    SignupBinding().dependencies();
  }
}

