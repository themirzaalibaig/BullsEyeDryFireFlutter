import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

enum Environment { dev, staging, prod }

class AppConfig {
  AppConfig._();

  static Environment _environment = Environment.dev;
  static Environment get environment => _environment;

  static Future<void> init(Environment env) async {
    _environment = env;
    try {
      await dotenv.load(fileName: _getEnvFile());
    } catch (e) {
      if (kDebugMode) {
        print('Warning: Could not load .env file: $e');
      }
    }
  }

  static String _getEnvFile() {
    switch (_environment) {
      case Environment.dev:
        return '.env.development';
      case Environment.staging:
        return '.env.staging';
      case Environment.prod:
        return '.env.production';
    }
  }

  // API Configuration
  static String get apiBaseUrl {
    return dotenv.get('API_BASE_URL', fallback: 'https://api.example.com');
  }

  static String get apiKey {
    return dotenv.get('API_KEY', fallback: '');
  }

  // Feature Flags
  static bool get enableAnalytics =>
      dotenv.get('ENABLE_ANALYTICS', fallback: 'true') == 'true';
  static bool get enableCrashReporting =>
      dotenv.get('ENABLE_CRASH_REPORTING', fallback: 'true') == 'true';

  // App Info
  static bool get isProduction => _environment == Environment.prod;
  static bool get isDevelopment => _environment == Environment.dev;
  static bool get isStaging => _environment == Environment.staging;

  static bool get enableLogging => !isProduction || kDebugMode;
}
