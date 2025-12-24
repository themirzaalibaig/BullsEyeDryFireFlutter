import 'package:get/get.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/language/presentation/pages/language_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/splash/presentation/bindings/splash_binding.dart';
import '../../features/language/presentation/bindings/language_binding.dart';
import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/onboarding/presentation/bindings/onboarding_binding.dart';
import '../../features/auth/presentation/bindings/signup_binding.dart';
import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/bindings/otp_verification_binding.dart';
import '../../features/auth/presentation/bindings/forgot_password_binding.dart';
import '../../features/auth/presentation/bindings/reset_password_binding.dart';
import '../../features/subscription/presentation/pages/subscription_page.dart';
import '../../features/subscription/presentation/pages/pricing_page.dart';
import '../../features/subscription/presentation/pages/payment_method_page.dart';
import '../../features/subscription/presentation/pages/payment_success_page.dart';
import '../../features/subscription/presentation/bindings/subscription_binding.dart';
import '../../features/subscription/presentation/bindings/pricing_binding.dart';
import '../../features/subscription/presentation/bindings/payment_binding.dart';
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
      name: AppConstants.languageRoute,
      page: () => const LanguagePage(),
      binding: LanguageBinding(),
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
    GetPage(
      name: AppConstants.signupRoute,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppConstants.loginRoute,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppConstants.otpVerificationRoute,
      page: () => const OTPVerificationPage(),
      binding: OTPVerificationBinding(),
    ),
    GetPage(
      name: AppConstants.forgotPasswordRoute,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppConstants.resetPasswordRoute,
      page: () => const ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppConstants.subscriptionRoute,
      page: () => const SubscriptionPage(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: AppConstants.pricingRoute,
      page: () => const PricingPage(),
      binding: PricingBinding(),
    ),
    GetPage(
      name: AppConstants.paymentMethodRoute,
      page: () => const PaymentMethodPage(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: AppConstants.paymentSuccessRoute,
      page: () => const PaymentSuccessPage(),
    ),
  ];
}
