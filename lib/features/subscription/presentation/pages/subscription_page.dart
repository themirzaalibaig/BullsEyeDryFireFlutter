import 'package:bullseye_dryfire/shared/widgets/auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/subscription_controller.dart';
import '../widgets/train_carousel_item.dart';
import '../widgets/track_carousel_item.dart';
import '../widgets/features_carousel_item.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();

    Widget renderCarouselItem(int index) {
      final item = controller.carouselItems[index];
      switch (item.type) {
        case CarouselItemType.train:
          return const TrainCarouselItem();
        case CarouselItemType.track:
          return const TrackCarouselItem();
        case CarouselItemType.features:
          return const FeaturesCarouselItem();
      }
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const AuthAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Upgrade to Pro',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.appName.toUpperCase(),
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // PRO Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 0.5,
                          width: 40,
                          color: AppColors.secondary,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          color: AppColors.secondary,
                          child: Text(
                            'PRO',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: AppColors.tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          width: 40,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Discover the subscription plan that aligns perfectly with your unique needs and training goals.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.tertiary.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            // Carousel Section
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: controller.carouselItems.length,
                      itemBuilder: (context, index, realIndex) {
                        return renderCarouselItem(index);
                      },
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          controller.setCurrentIndex(index);
                        },
                      ),
                    ),
                  ),
                  // Pagination Dots
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.carouselItems.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final isActive = index == controller.currentIndex.value;
                        return Container(
                          width: isActive ? 32 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.secondary
                                : AppColors.tertiary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            // Bottom Section
            Column(
              children: [
                Obx(
                  () => AppButton(
                    text: 'Upgrade to Pro'.toUpperCase(),
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.handleUpgradeNow,
                    isLoading: controller.isLoading.value,
                    variant: AppButtonVariant.default_,
                  ),
                ),
                TextButton(
                  onPressed: controller.handleNoThanks,
                  child: Text(
                    'No thanks',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.tertiary,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
