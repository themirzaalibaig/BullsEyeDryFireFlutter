import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';

enum HomeTab { feed, compete, train, metrics, profile }

class HomeController extends GetxController {
  final Rx<HomeTab> currentTab = HomeTab.feed.obs;

  void changeTab(HomeTab tab) {
    currentTab.value = tab;
  }

  void navigateToSubscription() {
    Get.toNamed(AppConstants.subscriptionRoute);
  }
}
