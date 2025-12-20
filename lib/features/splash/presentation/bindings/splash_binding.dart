import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Use put instead of lazyPut to ensure controller is initialized immediately
    Get.put<SplashController>(SplashController(), permanent: false);
  }
}
