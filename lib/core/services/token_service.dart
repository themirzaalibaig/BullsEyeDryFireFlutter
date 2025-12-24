import 'package:get/get.dart';
import 'secure_storage_service.dart';
import '../utils/logger.dart';

class TokenService extends GetxService {
  static TokenService get to => Get.find();

  final SecureStorageService _storage = SecureStorageService.to;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // Access Token
  Future<void> saveAccessToken(String token) async {
    try {
      await _storage.write(_accessTokenKey, token);
      AppLogger.info('Access token saved');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to save access token', e, stackTrace);
    }
  }

  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(_accessTokenKey);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get access token', e, stackTrace);
      return null;
    }
  }

  Future<void> deleteAccessToken() async {
    try {
      await _storage.delete(_accessTokenKey);
      AppLogger.info('Access token deleted');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete access token', e, stackTrace);
    }
  }

  // Refresh Token
  Future<void> saveRefreshToken(String token) async {
    try {
      await _storage.write(_refreshTokenKey, token);
      AppLogger.info('Refresh token saved');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to save refresh token', e, stackTrace);
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(_refreshTokenKey);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get refresh token', e, stackTrace);
      return null;
    }
  }

  Future<void> deleteRefreshToken() async {
    try {
      await _storage.delete(_refreshTokenKey);
      AppLogger.info('Refresh token deleted');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete refresh token', e, stackTrace);
    }
  }

  // Save both tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  // Delete all tokens
  Future<void> clearTokens() async {
    await Future.wait([deleteAccessToken(), deleteRefreshToken()]);
    AppLogger.info('All tokens cleared');
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
}
