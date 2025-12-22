import 'package:bullseye_dryfire/shared/widgets/auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/pricing_controller.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PricingController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const AuthAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  'Upgrade to Pro',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  AppConstants.appName.toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
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
                        horizontal: 12,
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
                const SizedBox(height: 10),
                Text(
                  'Discover the subscription plan that aligns perfectly with your unique needs and training goals.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.tertiary.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),
              ],
            ),

            // Plans Section
            Expanded(
              child: Column(
                children: [
                  // Monthly Plan
                  GestureDetector(
                    onTap: () =>
                        controller.setSelectedPlan(SubscriptionPlan.monthly),
                    child: Obx(
                      () => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                controller.selectedPlan.value ==
                                    SubscriptionPlan.monthly
                                ? AppColors.secondary
                                : AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Monthly',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.quaternary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Renews every month',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.quaternary),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 0.5,
                              width: double.infinity,
                              color: AppColors.secondary,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            Text(
                              '14 Days free for new subscribers',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.quaternary),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$10',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: AppColors.quaternary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Yearly Plan
                  GestureDetector(
                    onTap: () =>
                        controller.setSelectedPlan(SubscriptionPlan.yearly),
                    child: Obx(
                      () => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                controller.selectedPlan.value ==
                                    SubscriptionPlan.yearly
                                ? AppColors.secondary
                                : AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Yearly',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.quaternary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Renews every year best value!',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.quaternary),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 0.5,
                              width: double.infinity,
                              color: AppColors.secondary,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            Text(
                              '14 Days free for new subscribers',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.quaternary),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$99',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: AppColors.quaternary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Cancel Anytime Text
                  Text(
                    'you can cancel anytime',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.tertiary.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Free Trial Text
                  Text(
                    'Free Trial 14 Days',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.tertiary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Section
            Column(
              children: [
                Obx(
                  () => AppButton(
                    text: controller.selectedPlan.value == null
                        ? 'CONTINUE WITH FREE'
                        : 'SUBSCRIBE NOW',
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.handleSubscribe,
                    isLoading: controller.isLoading.value,
                    variant: AppButtonVariant.default_,
                  ),
                ),
                TextButton(
                  onPressed: controller.handleNoThanks,
                  child: Text(
                    'No, thanks',
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
