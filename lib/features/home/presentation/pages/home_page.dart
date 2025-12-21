import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/language_selector_dialog.dart';
import '../../../../core/widgets/language_dropdown.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/auth_welcome.dart';
import '../controllers/home_controller.dart';
import '../../../../core/constants/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showLanguageSelector(BuildContext context, HomeController controller) {
    LanguageSelectorDialog.show(
      context: context,
      languages: controller.availableLanguages,
      selectedLanguage: controller.selectedLanguage.value,
      onLanguageSelected: (language) {
        controller.selectLanguageWithContext(language, context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Top section with welcome
            const AuthWelcome(),

            const Spacer(),

            // Center section with language selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Builder(
                    builder: (context) => Text(
                      context.tr('choose_language'),
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => LanguageDropdown(
                      selectedLanguage: controller.selectedLanguage.value,
                      onTap: () => _showLanguageSelector(context, controller),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Bottom section with next button (default variant: tertiary bg, quaternary fg)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Builder(
                builder: (context) => Obx(
                  () => AppButton(
                    text: context.tr('next').toUpperCase(),
                    onPressed: controller.selectedLanguage.value != null
                        ? controller.onNextPressed
                        : null,
                    isEnabled: controller.selectedLanguage.value != null,
                    variant: AppButtonVariant.default_,
                    borderRadius: 8,
                    icon: null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
