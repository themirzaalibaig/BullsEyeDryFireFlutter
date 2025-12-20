import 'package:get/get.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/splash/presentation/bindings/splash_binding.dart';
import '../../features/home/presentation/bindings/home_binding.dart';

class AppPages {
  AppPages._();

  static const initial = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
