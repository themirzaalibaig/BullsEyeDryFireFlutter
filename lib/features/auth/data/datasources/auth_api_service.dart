import '../../../../core/network/api_service.dart';
import '../../../../core/utils/logger.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthApiService extends ApiService {
  static const String basePath = '/auth';

  // Signup
  Future<AuthResponseModel> signup({
    required String username,
    required String email,
    required String password,
    String? phone,
    String? signupMethod,
  }) async {
    try {
      final response = await post(
        '$basePath/signup',
        data: {
          'username': username,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
          if (signupMethod != null) 'signupMethod': signupMethod,
        },
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Signup failed', e, stackTrace);
      rethrow;
    }
  }

  // Login
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await post(
        '$basePath/login',
        data: {'email': email, 'password': password},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Login failed', e, stackTrace);
      rethrow;
    }
  }

  // Guest Login
  Future<AuthResponseModel> guestLogin({String? username}) async {
    try {
      final response = await post(
        '$basePath/guest',
        data: username != null ? {'username': username} : {},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Guest login failed', e, stackTrace);
      rethrow;
    }
  }

  // Google OAuth
  Future<AuthResponseModel> googleSignIn({
    required String idToken,
    String? username,
  }) async {
    try {
      final response = await post(
        '$basePath/google',
        data: {'idToken': idToken, if (username != null) 'username': username},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Google sign in failed', e, stackTrace);
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
      final response = await post(
        '$basePath/verify-otp',
        data: {'email': email, 'otp': otp, 'type': type},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Verify OTP failed', e, stackTrace);
      rethrow;
    }
  }

  // Resend OTP
  Future<AuthResponseModel> resendOtp({
    required String email,
    String type = 'emailVerification',
  }) async {
    try {
      final response = await post(
        '$basePath/resend-otp',
        data: {'email': email, 'type': type},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Resend OTP failed', e, stackTrace);
      rethrow;
    }
  }

  // Forgot Password
  Future<AuthResponseModel> forgotPassword({required String email}) async {
    try {
      final response = await post(
        '$basePath/forgot-password',
        data: {'email': email},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Forgot password failed', e, stackTrace);
      rethrow;
    }
  }

  // Reset Password
  Future<AuthResponseModel> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await post(
        '$basePath/reset-password',
        data: {'email': email, 'password': password},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Reset password failed', e, stackTrace);
      rethrow;
    }
  }

  // Refresh Token
  Future<AuthResponseModel> refreshToken({required String refreshToken}) async {
    try {
      final response = await post(
        '$basePath/refresh-token',
        data: {'refreshToken': refreshToken},
        auth: false, // Public endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Refresh token failed', e, stackTrace);
      rethrow;
    }
  }

  // Get Current User (Protected)
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await get(
        '$basePath/me',
        auth: true, // Protected endpoint
      );

      final userData = (response.data as Map<String, dynamic>)['data']?['user'];
      if (userData == null) {
        throw Exception('User data not found in response');
      }

      return UserModel.fromJson(userData as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Get current user failed', e, stackTrace);
      rethrow;
    }
  }

  // Update Profile (Protected)
  Future<UserModel> updateProfile({
    String? username,
    String? phone,
    String? profilePicture,
  }) async {
    try {
      final response = await put(
        '$basePath/profile',
        data: {
          if (username != null) 'username': username,
          if (phone != null) 'phone': phone,
          if (profilePicture != null) 'profilePicture': profilePicture,
        },
        auth: true, // Protected endpoint
      );

      final userData = (response.data as Map<String, dynamic>)['data']?['user'];
      if (userData == null) {
        throw Exception('User data not found in response');
      }

      return UserModel.fromJson(userData as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Update profile failed', e, stackTrace);
      rethrow;
    }
  }

  // Change Password (Protected)
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await put(
        '$basePath/change-password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
        auth: true, // Protected endpoint
      );
    } catch (e, stackTrace) {
      AppLogger.error('Change password failed', e, stackTrace);
      rethrow;
    }
  }

  // Logout (Protected)
  Future<void> logout({required String refreshToken}) async {
    try {
      await post(
        '$basePath/logout',
        data: {'refreshToken': refreshToken},
        auth: true, // Protected endpoint
      );
    } catch (e, stackTrace) {
      AppLogger.error('Logout failed', e, stackTrace);
      rethrow;
    }
  }

  // Convert Guest to Registered (Protected)
  Future<AuthResponseModel> convertGuestToRegistered({
    required String email,
    required String password,
    String? username,
  }) async {
    try {
      final response = await post(
        '$basePath/convert-guest',
        data: {
          'email': email,
          'password': password,
          if (username != null) 'username': username,
        },
        auth: true, // Protected endpoint
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('Convert guest to registered failed', e, stackTrace);
      rethrow;
    }
  }
}
