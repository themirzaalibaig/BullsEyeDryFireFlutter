import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';

enum CarouselItemType { train, track, features }

class CarouselItem {
  final CarouselItemType type;
  final String title;

  CarouselItem({required this.type, required this.title});
}

class SubscriptionController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isLoading = false.obs;

  final List<CarouselItem> carouselItems = [
    CarouselItem(type: CarouselItemType.train, title: 'Train'),
    CarouselItem(type: CarouselItemType.track, title: 'Track'),
    CarouselItem(type: CarouselItemType.features, title: 'Features'),
  ];

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void handleUpgradeNow() {
    AppLogger.info('Upgrade to Pro pressed');
    Get.toNamed(AppConstants.pricingRoute);
  }

  void handleNoThanks() {
    AppLogger.info('No thanks pressed');
    Get.back();
  }

  void handleBack() {
    AppLogger.info('Back pressed');
    Get.back();
  }
}

