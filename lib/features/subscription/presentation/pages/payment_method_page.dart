import 'package:bullseye_dryfire/shared/widgets/auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/payment_controller.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const AuthAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Top Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Select your preferred payment method',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.tertiary.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Payment Methods Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Stripe Card Payment Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.tertiary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.credit_card,
                            size: 48,
                            color: AppColors.quaternary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Credit/Debit Card',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: AppColors.quaternary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pay securely with Stripe',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.quaternary.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          // TODO: Replace with actual Stripe Card Widget in production
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.quaternary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Card details will be integrated with Stripe SDK',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.quaternary),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Security Note
                    Row(
                      children: [
                        const Icon(
                          Icons.lock,
                          size: 16,
                          color: AppColors.tertiary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Your payment information is secure and encrypted',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.tertiary.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(
                () => AppButton(
                  text: 'PAY NOW',
                  onPressed: controller.isProcessing.value
                      ? null
                      : controller.processPayment,
                  isLoading: controller.isProcessing.value,
                  variant: AppButtonVariant.default_,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
