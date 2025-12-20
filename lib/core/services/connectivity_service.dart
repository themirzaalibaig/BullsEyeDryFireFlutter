import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import '../utils/logger.dart';

class ConnectivityService extends GetxService {
  static ConnectivityService get to => Get.find();

  final Connectivity _connectivity = Connectivity();
  final _connectivityController = StreamController<ConnectivityResult>.broadcast();

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivityController.stream;
  ConnectivityResult _currentStatus = ConnectivityResult.none;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen((results) {
      _updateConnectionStatus(results.isNotEmpty ? results.first : ConnectivityResult.none);
    });
  }

  Future<void> _initConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _currentStatus = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _connectivityController.add(_currentStatus);
    } catch (e) {
      AppLogger.error('Failed to check connectivity', e);
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _currentStatus = result;
    _connectivityController.add(result);
    AppLogger.info('Connectivity changed: $result');
  }

  bool get isConnected {
    return _currentStatus != ConnectivityResult.none;
  }

  bool get isWifi => _currentStatus == ConnectivityResult.wifi;
  bool get isMobile => _currentStatus == ConnectivityResult.mobile;
  bool get isEthernet => _currentStatus == ConnectivityResult.ethernet;

  Future<List<ConnectivityResult>> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

  @override
  void onClose() {
    _connectivityController.close();
    super.onClose();
  }
}

