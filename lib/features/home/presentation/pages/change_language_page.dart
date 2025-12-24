import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/language_selector_dialog.dart';
import '../../../../core/widgets/language_dropdown.dart';
import '../../../language/presentation/controllers/language_controller.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  LanguageController _getLanguageController() {
    if (Get.isRegistered<LanguageController>()) {
      return Get.find<LanguageController>();
    } else {
      final controller = LanguageController();
      Get.put(controller, permanent: false);
      return controller;
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final languageController = _getLanguageController();

    LanguageSelectorDialog.show(
      context: context,
      languages: languageController.availableLanguages,
      selectedLanguage: languageController.selectedLanguage.value,
      onLanguageSelected: (language) {
        languageController.selectLanguageWithContext(language, context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageController = _getLanguageController();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.tertiary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.tr('change_language'),
          style: const TextStyle(
            color: AppColors.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                context.tr('select_language'),
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.tertiary,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => LanguageDropdown(
                  selectedLanguage: languageController.selectedLanguage.value,
                  onTap: () => _showLanguageSelector(context),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                context.tr('language_change_note'),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.nonary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
