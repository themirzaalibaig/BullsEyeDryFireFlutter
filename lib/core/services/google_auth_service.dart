import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/logger.dart';
import '../utils/error_handler.dart';
import '../constants/app_constants.dart';
import 'google_sign_in_service.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/data/models/auth_response_model.dart';

class GoogleAuthService extends GetxService {
  static GoogleAuthService get to => Get.find();

  final AuthRepository _authRepository = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;

  /// Sign in with Google (handles both frontend and backend authentication)
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      AppLogger.info('Initiating Google Sign-In...');

      final GoogleSignInAccount? account = await GoogleSignInService.signIn();

      if (account != null) {
        AppLogger.info('Google Sign-In successful');

        // Get Google authentication credentials
        final GoogleSignInAuthentication googleAuth =
            account.authentication;
        final String? googleIdToken = googleAuth.idToken;

        if (googleIdToken == null) {
          throw Exception('Failed to get ID token from Google');
        }

        // Create Firebase credential using Google ID token
        // Firebase will handle the access token internally
        final credential = GoogleAuthProvider.credential(
          idToken: googleIdToken,
        );

        // Sign in to Firebase with Google credential
        AppLogger.info('Signing in to Firebase with Google credential...');
        final UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(credential);

        // Get Firebase ID token (this is what the backend needs)
        final String? firebaseIdToken = await userCredential.user?.getIdToken();

        if (firebaseIdToken == null) {
          throw Exception('Failed to get Firebase ID token');
        }

        AppLogger.info('Firebase authentication successful');

        // Call backend API with Firebase ID token
        final AuthResponseModel response = await _authRepository.googleSignIn(
          idToken:
              firebaseIdToken, // Send Firebase ID token, not Google ID token
          username: account.displayName ?? userCredential.user?.displayName,
        );

        if (response.success && response.user != null) {
          AppLogger.info('Backend authentication successful');
          // Navigate to home after successful sign-in
          Get.offAllNamed(AppConstants.homeRoute);
        } else {
          // Handle API response errors
          ErrorHandler.handleApiResponse(
            success: response.success,
            message: response.message,
            errors: response.errors?.map((e) => e.toJson()).toList(),
          );
        }
      } else {
        AppLogger.warning('User cancelled Google Sign-In');
        ErrorHandler.showInfo('Google Sign-In was cancelled');
        return; // Don't throw error for cancellation
      }
    } catch (e, stackTrace) {
      AppLogger.error('Google Sign-In error', e, stackTrace);
      // Check if it's a cancellation error
      if (e.toString().contains('cancelled') ||
          e.toString().contains('Cancelled')) {
        ErrorHandler.showInfo('Google Sign-In was cancelled');
      } else {
        ErrorHandler.handleError(
          e,
          defaultMessage: 'Failed to sign in with Google. Please try again.',
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign out from both Google and Firebase
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      AppLogger.info('Signing out from Google and Firebase...');

      // Sign out from Firebase
      await _firebaseAuth.signOut();

      // Sign out from Google
      await GoogleSignInService.signOut();

      AppLogger.info('Sign out successful');
    } catch (e, stackTrace) {
      AppLogger.error('Sign out error', e, stackTrace);
      ErrorHandler.handleError(
        e,
        defaultMessage: 'Failed to sign out. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
