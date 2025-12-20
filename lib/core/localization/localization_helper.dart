import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Helper class for managing localization
/// Uses easy_localization package for better localization management
class LocalizationHelper {
  LocalizationHelper._();

  /// Initialize localization
  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }

  /// Get current locale
  static Locale? getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  /// Change locale
  static Future<void> setLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  /// Get supported locales
  static List<Locale> getSupportedLocales() {
    return [
      const Locale('en', 'US'),
      const Locale('es', 'ES'),
      const Locale('fr', 'FR'),
      const Locale('de', 'DE'),
      const Locale('it', 'IT'),
      const Locale('pt', 'PT'),
      const Locale('ru', 'RU'),
      const Locale('ja', 'JP'),
      const Locale('ko', 'KR'),
      const Locale('zh', 'CN'),
      const Locale('ar', 'SA'),
      const Locale('hi', 'IN'),
    ];
  }

  /// Translate a key
  static String tr(String key, {List<String>? args}) {
    return key.tr(args: args);
  }
}
