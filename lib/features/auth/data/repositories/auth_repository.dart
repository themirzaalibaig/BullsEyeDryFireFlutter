import '../../../../core/utils/logger.dart';
import '../../../../core/services/token_service.dart';
import '../datasources/auth_api_service.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthApiService _apiService = AuthApiService();
  final TokenService _tokenService = TokenService.to;

  // Signup
  Future<AuthResponseModel> signup({
    required String username,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _apiService.signup(
        username: username,
        email: email,
        password: password,
        phone: phone,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Signup repository error', e, stackTrace);
      rethrow;
    }
  }

  // Login
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      // Save tokens if available
      if (response.token != null) {
        await _tokenService.saveTokens(
          response.token!.accessToken,
          response.token!.refreshToken,
        );
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Login repository error', e, stackTrace);
      rethrow;
    }
  }

  // Guest Login
  Future<AuthResponseModel> guestLogin({String? username}) async {
    try {
      final response = await _apiService.guestLogin(username: username);

      if (!response.success) {
        throw Exception(response.message);
      }

      // Save tokens if available
      if (response.token != null) {
        await _tokenService.saveTokens(
          response.token!.accessToken,
          response.token!.refreshToken,
        );
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Guest login repository error', e, stackTrace);
      rethrow;
    }
  }

  // Google Sign In
  Future<AuthResponseModel> googleSignIn({
    required String idToken,
    String? username,
  }) async {
    try {
      final response = await _apiService.googleSignIn(
        idToken: idToken,
        username: username,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      // Save tokens if available
      if (response.token != null) {
        await _tokenService.saveTokens(
          response.token!.accessToken,
          response.token!.refreshToken,
        );
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Google sign in repository error', e, stackTrace);
      rethrow;
    }
  }

  // Verify OTP
  Future<AuthResponseModel> verifyOtp({
    required String email,
    required String otp,
    String type = 'emailVerification',
  }) async {
    try {
      final response = await _apiService.verifyOtp(
        email: email,
        otp: otp,
        type: type,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Verify OTP repository error', e, stackTrace);
      rethrow;
    }
  }

  // Resend OTP
  Future<AuthResponseModel> resendOtp({
    required String email,
    String type = 'emailVerification',
  }) async {
    try {
      final response = await _apiService.resendOtp(email: email, type: type);

      if (!response.success) {
        throw Exception(response.message);
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Resend OTP repository error', e, stackTrace);
      rethrow;
    }
  }

  // Forgot Password
  Future<AuthResponseModel> forgotPassword({required String email}) async {
    try {
      final response = await _apiService.forgotPassword(email: email);

      if (!response.success) {
        throw Exception(response.message);
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Forgot password repository error', e, stackTrace);
      rethrow;
    }
  }

  // Reset Password
  Future<AuthResponseModel> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.resetPassword(
        email: email,
        password: password,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Reset password repository error', e, stackTrace);
      rethrow;
    }
  }

  // Get Current User
  Future<UserModel> getCurrentUser() async {
    try {
      return await _apiService.getCurrentUser();
    } catch (e, stackTrace) {
      AppLogger.error('Get current user repository error', e, stackTrace);
      rethrow;
    }
  }

  // Update Profile
  Future<UserModel> updateProfile({
    String? username,
    String? phone,
    String? profilePicture,
  }) async {
    try {
      return await _apiService.updateProfile(
        username: username,
        phone: phone,
        profilePicture: profilePicture,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Update profile repository error', e, stackTrace);
      rethrow;
    }
  }

  // Change Password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Change password repository error', e, stackTrace);
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final refreshToken = await _tokenService.getRefreshToken();
      if (refreshToken != null) {
        await _apiService.logout(refreshToken: refreshToken);
      }
      await _tokenService.clearTokens();
    } catch (e, stackTrace) {
      AppLogger.error('Logout repository error', e, stackTrace);
      // Clear tokens even if logout API call fails
      await _tokenService.clearTokens();
      rethrow;
    }
  }

  // Convert Guest to Registered
  Future<AuthResponseModel> convertGuestToRegistered({
    required String email,
    required String password,
    String? username,
  }) async {
    try {
      final response = await _apiService.convertGuestToRegistered(
        email: email,
        password: password,
        username: username,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      // Update tokens if new ones are provided
      if (response.token != null) {
        await _tokenService.saveTokens(
          response.token!.accessToken,
          response.token!.refreshToken,
        );
      }

      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Convert guest repository error', e, stackTrace);
      rethrow;
    }
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _tokenService.isAuthenticated();
  }
}
