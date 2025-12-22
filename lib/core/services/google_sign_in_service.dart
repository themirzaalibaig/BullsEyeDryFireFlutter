import 'package:google_sign_in/google_sign_in.dart';
import '../utils/logger.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool _isInitialized = false;

  /// Initialize Google Sign-In with server client ID (optional, for backend auth)
  static Future<void> initSignIn({String? serverClientId}) async {
    if (!_isInitialized && serverClientId != null) {
      try {
        await _googleSignIn.initialize(serverClientId: serverClientId);
        _isInitialized = true;
        AppLogger.info('Google Sign-In initialized with server client ID');
      } catch (e, stackTrace) {
        AppLogger.error('Failed to initialize Google Sign-In', e, stackTrace);
        rethrow;
      }
    }
  }

  /// Sign in with Google (interactive)
  static Future<GoogleSignInAccount?> signIn() async {
    try {
      AppLogger.info('Starting Google Sign-In...');

      // Ensure Google Sign-In is initialized (required for Android)
      if (!_isInitialized) {
        AppLogger.warning(
          'Google Sign-In not initialized. Please call initSignIn() first.',
        );
        throw Exception(
          'Google Sign-In must be initialized before use. Call initSignIn() with serverClientId.',
        );
      }

      // Try silent sign-in first (if user was previously signed in)
      GoogleSignInAccount? account;
      try {
        account = await _googleSignIn.authenticate();
      } catch (e) {
        AppLogger.info('Silent sign-in not available: $e');
      }

      if (account != null) {
        AppLogger.info('Google Sign-In successful');
        AppLogger.info('User ID: ${account.id}');
        AppLogger.info('Email: ${account.email}');
        AppLogger.info('Display Name: ${account.displayName}');
        AppLogger.info('Photo URL: ${account.photoUrl}');
      } else {
        AppLogger.warning('Google Sign-In cancelled by user');
      }

      return account;
    } catch (e, stackTrace) {
      AppLogger.error('Google Sign-In failed', e, stackTrace);
      rethrow;
    }
  }

  /// Sign out from Google
  static Future<void> signOut() async {
    try {
      AppLogger.info('Signing out from Google...');
      await _googleSignIn.signOut();
      AppLogger.info('Google Sign-Out successful');
    } catch (e, stackTrace) {
      AppLogger.error('Google Sign-Out failed', e, stackTrace);
      rethrow;
    }
  }

  /// Check if user is currently signed in
  static Future<bool> isSignedIn() async {
    try {
      final account = await _googleSignIn.authenticate();
      final auth = account.authentication;
      return auth.idToken != null;
    } catch (e) {
      AppLogger.warning('Error checking sign-in status: $e');
      return false;
    }
  }

  /// Get current user (if signed in)
  static Future<GoogleSignInAccount?> getCurrentUser() async {
    try {
      return await _googleSignIn.authenticate();
    } catch (e) {
      AppLogger.warning('Error getting current user: $e');
      return null;
    }
  }

  /// Disconnect from Google (revokes access)
  static Future<void> disconnect() async {
    try {
      AppLogger.info('Disconnecting from Google...');
      await _googleSignIn.disconnect();
      AppLogger.info('Google Disconnect successful');
    } catch (e, stackTrace) {
      AppLogger.error('Google Disconnect failed', e, stackTrace);
      rethrow;
    }
  }
}
