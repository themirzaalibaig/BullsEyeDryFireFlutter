import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'permission_service.dart';
import '../utils/logger.dart';

class ImagePickerService extends GetxService {
  static ImagePickerService get to => Get.find();

  final ImagePicker _picker = ImagePicker();
  final PermissionService _permissionService = Get.find();

  Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      // Request permission for camera if needed
      if (source == ImageSource.camera) {
        final hasPermission = await _permissionService.requestPermission(
          Permission.camera,
        );
        if (!hasPermission) {
          return null;
        }
      } else {
        // Request permission for photos
        if (Platform.isIOS) {
          final hasPermission = await _permissionService.requestPermission(
            Permission.photos,
          );
          if (!hasPermission) {
            return null;
          }
        }
      }

      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      AppLogger.error('Image picker failed', e);
      return null;
    }
  }

  Future<List<File>> pickMultipleImages({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      return images.map((xFile) => File(xFile.path)).whereType<File>().toList();
    } catch (e) {
      AppLogger.error('Multiple image picker failed', e);
      return [];
    }
  }
}

