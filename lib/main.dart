import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'core/services/google_sign_in_service.dart';
import 'core/services/google_auth_service.dart';
import 'core/services/token_service.dart';
import 'core/localization/localization_helper.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Easy Localization
  await EasyLocalization.ensureInitialized();

  // Initialize environment
  await AppConfig.init(Environment.dev);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize services
  Get.put(PathService());
  Get.put(SecureStorageService());
  Get.put(
    TokenService(),
  ); // Token service must be initialized after SecureStorageService
  Get.put(PermissionService());
  Get.put(ConnectivityService());
  Get.put(ImagePickerService());
  Get.put(AppUpdateService());

  // Initialize Google Sign-In (required for Android)
  await GoogleSignInService.initSignIn(
    serverClientId: AppConstants.googleServerClientId,
  );

  // Initialize Google Auth Service
  Get.put(GoogleAuthService());

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationHelper.getSupportedLocales(),
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      useOnlyLangCode: false,
      child: const MyApp(),
    ),
  );
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
