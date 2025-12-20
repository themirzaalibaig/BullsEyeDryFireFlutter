import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/logger.dart';
import '../widgets/error_handler.dart';

class PermissionService extends GetxService {
  static PermissionService get to => Get.find();

  Future<bool> requestPermission(Permission permission) async {
    try {
      final status = await permission.status;

      if (status.isGranted) {
        return true;
      }

      if (status.isDenied) {
        final result = await permission.request();
        return result.isGranted;
      }

      if (status.isPermanentlyDenied) {
        ErrorHandler.handleError(
          'Permission is permanently denied. Please enable it in settings.',
        );
        return false;
      }

      return false;
    } catch (e) {
      AppLogger.error('Permission request failed', e);
      return false;
    }
  }

  Future<bool> requestMultiplePermissions(List<Permission> permissions) async {
    final statuses = await permissions.request();
    return statuses.values.every((status) => status.isGranted);
  }

  Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }
}

