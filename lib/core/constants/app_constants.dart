class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Bulls Eye Dry Fire';
  static const String appTagline = 'Safely Practice Anywhere';

  // API Configuration
  static const String apiBaseUrl = 'https://api.example.com/v1';
  static const int apiTimeout = 30; // seconds

  // Assets Paths (images)
  static const String logoPath = 'lib/assets/images/logo.png';
  static const String launcherIconPath = 'lib/assets/images/ic_launcher.png';
  static const String targetImagePath = 'lib/assets/images/target.png';

  // Assets Paths (icons)
  static const String googleIconPath = 'lib/assets/icons/google.png';
  static const String angleIconPath = 'lib/assets/icons/angle-icon.png';
  static const String targetIconPath = 'lib/assets/icons/target-icon.png';

  // Splash Screen
  static const int splashDuration = 3; // seconds

  // Routes
  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String onboardingRoute = '/onboarding';
}
