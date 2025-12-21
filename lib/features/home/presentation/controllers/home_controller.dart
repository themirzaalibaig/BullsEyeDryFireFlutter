import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/language_selector.dart';
import '../../../../core/constants/app_constants.dart';

class HomeController extends GetxController {
  final Rx<Language?> selectedLanguage = Rx<Language?>(null);

  final List<Language> availableLanguages = [
    Language(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      locale: const Locale('en', 'US'),
      flagEmoji: '🇺🇸',
    ),
    Language(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      locale: const Locale('es', 'ES'),
      flagEmoji: '🇪🇸',
    ),
    Language(
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      locale: const Locale('fr', 'FR'),
      flagEmoji: '🇫🇷',
    ),
    Language(
      code: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      locale: const Locale('de', 'DE'),
      flagEmoji: '🇩🇪',
    ),
    Language(
      code: 'it',
      name: 'Italian',
      nativeName: 'Italiano',
      locale: const Locale('it', 'IT'),
      flagEmoji: '🇮🇹',
    ),
    Language(
      code: 'pt',
      name: 'Portuguese',
      nativeName: 'Português',
      locale: const Locale('pt', 'PT'),
      flagEmoji: '🇵🇹',
    ),
    Language(
      code: 'ru',
      name: 'Russian',
      nativeName: 'Русский',
      locale: const Locale('ru', 'RU'),
      flagEmoji: '🇷🇺',
    ),
    Language(
      code: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      locale: const Locale('ja', 'JP'),
      flagEmoji: '🇯🇵',
    ),
    Language(
      code: 'ko',
      name: 'Korean',
      nativeName: '한국어',
      locale: const Locale('ko', 'KR'),
      flagEmoji: '🇰🇷',
    ),
    Language(
      code: 'zh',
      name: 'Chinese',
      nativeName: '中文',
      locale: const Locale('zh', 'CN'),
      flagEmoji: '🇨🇳',
    ),
    Language(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      locale: const Locale('ar', 'SA'),
      flagEmoji: '🇸🇦',
    ),
    Language(
      code: 'hi',
      name: 'Hindi',
      nativeName: 'हिन्दी',
      locale: const Locale('hi', 'IN'),
      flagEmoji: '🇮🇳',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Set default language to English
    selectedLanguage.value = availableLanguages.firstWhere(
      (lang) => lang.code == 'en',
      orElse: () => availableLanguages.first,
    );
  }

  void selectLanguage(Language language) {
    selectedLanguage.value = language;
    Get.updateLocale(language.locale);
  }

  void selectLanguageWithContext(Language language, BuildContext context) {
    selectedLanguage.value = language;
    Get.updateLocale(language.locale);
    context.setLocale(language.locale);
  }

  void onNextPressed() {
    Get.toNamed(AppConstants.onboardingRoute);
  }
}
