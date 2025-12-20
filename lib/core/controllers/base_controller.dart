import 'package:get/get.dart';
import '../utils/logger.dart';
import '../widgets/error_handler.dart';
import '../services/connectivity_service.dart';

abstract class BaseController extends GetxController {
  final ConnectivityService _connectivityService = Get.find();

  // Loading state
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  void setLoading(bool value) => _isLoading.value = value;

  // Error state
  final _error = RxString('');
  String? get error => _error.value.isEmpty ? null : _error.value;
  void setError(String? value) => _error.value = value ?? '';

  // Success state
  final _successMessage = RxString('');
  String? get successMessage =>
      _successMessage.value.isEmpty ? null : _successMessage.value;
  void setSuccessMessage(String? value) => _successMessage.value = value ?? '';

  // Connectivity
  bool get isConnected => _connectivityService.isConnected;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    // Override in child controllers
  }

  // Safe API call wrapper
  Future<T?> safeApiCall<T>(
    Future<T> Function() apiCall, {
    String? errorMessage,
    bool showError = true,
  }) async {
    try {
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      setLoading(true);
      setError(null);

      final result = await apiCall();

      setLoading(false);
      return result;
    } catch (e) {
      setLoading(false);
      final message = errorMessage ?? e.toString();
      setError(message);

      if (showError) {
        ErrorHandler.handleError(e);
      }

      AppLogger.error('API call failed', e);
      return null;
    }
  }

}

