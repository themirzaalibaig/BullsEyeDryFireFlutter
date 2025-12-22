import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';

enum SubscriptionPlan { monthly, yearly }

class PricingController extends GetxController {
  final Rx<SubscriptionPlan?> selectedPlan = SubscriptionPlan.yearly.obs;
  final RxBool isLoading = false.obs;

  void setSelectedPlan(SubscriptionPlan plan) {
    selectedPlan.value = plan;
  }

  void handleSubscribe() async {
    try {
      isLoading.value = true;
      AppLogger.info('Subscribe pressed - Plan: ${selectedPlan.value}');

      // TODO: Implement subscription logic
      // For now, navigate to payment method screen
      Get.toNamed(
        AppConstants.paymentMethodRoute,
        arguments: {'plan': selectedPlan.value},
      );
    } catch (e, stackTrace) {
      AppLogger.error('Subscribe error', e, stackTrace);
      Get.snackbar(
        'Error',
        'Failed to process subscription. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
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

