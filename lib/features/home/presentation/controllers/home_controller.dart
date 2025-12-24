import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';

enum HomeTab { home, training, profile, settings }

class HomeController extends GetxController {
  final Rx<HomeTab> currentTab = HomeTab.home.obs;

  void changeTab(HomeTab tab) {
    currentTab.value = tab;
  }

  void navigateToSubscription() {
    Get.toNamed(AppConstants.subscriptionRoute);
  }
}
