import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/config/app_config.dart';
import 'core/widgets/error_boundary.dart';
import 'core/services/path_service.dart';
import 'core/services/secure_storage_service.dart';
import 'core/services/permission_service.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/image_picker_service.dart';
import 'core/services/app_update_service.dart';
import 'core/localization/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment
  await AppConfig.init(Environment.dev);

  // Initialize services
  Get.put(PathService());
  Get.put(SecureStorageService());
  Get.put(PermissionService());
  Get.put(ConnectivityService());
  Get.put(ImagePickerService());
  Get.put(AppUpdateService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      child: GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        translations: AppTranslations(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
      ),
    );
  }
}
