import 'package:get/get.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/bindings/splash_binding.dart';
import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/onboarding/presentation/bindings/onboarding_binding.dart';
import '../../core/constants/app_constants.dart';

class AppPages {
  AppPages._();

  static const initial = AppConstants.splashRoute;

  static final routes = [
    GetPage(
      name: AppConstants.splashRoute,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppConstants.homeRoute,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppConstants.onboardingRoute,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
  ];
}
