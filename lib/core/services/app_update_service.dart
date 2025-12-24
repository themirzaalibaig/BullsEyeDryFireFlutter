import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import '../utils/logger.dart';
import '../utils/error_handler.dart';

class AppUpdateService extends GetxService {
  static AppUpdateService get to => Get.find();

  Future<void> checkForUpdate() async {
    try {
      final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          // Start flexible update
          await InAppUpdate.startFlexibleUpdate();
        } else {
          ErrorHandler.handleError(
            'Update available but cannot be installed',
          );
        }
      } else {
        AppLogger.info('App is up to date');
      }
    } catch (e) {
      AppLogger.error('Failed to check for update', e);
    }
  }

  Future<void> completeFlexibleUpdate() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
    } catch (e) {
      AppLogger.error('Failed to complete flexible update', e);
    }
  }
}

