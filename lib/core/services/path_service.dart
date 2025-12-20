import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../utils/logger.dart';

class PathService extends GetxService {
  static PathService get to => Get.find();

  String? _appDocumentsPath;
  String? _appCachePath;
  String? _appSupportPath;
  String? _tempPath;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializePaths();
  }

  Future<void> _initializePaths() async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      _appDocumentsPath = appDocDir.path;

      final cacheDir = await getTemporaryDirectory();
      _appCachePath = cacheDir.path;

      final supportDir = await getApplicationSupportDirectory();
      _appSupportPath = supportDir.path;

      final tempDir = Directory.systemTemp;
      _tempPath = tempDir.path;

      AppLogger.info('Paths initialized successfully');
      AppLogger.debug('Documents: $_appDocumentsPath');
      AppLogger.debug('Cache: $_appCachePath');
      AppLogger.debug('Support: $_appSupportPath');
      AppLogger.debug('Temp: $_tempPath');
    } catch (e) {
      AppLogger.error('Failed to initialize paths', e);
    }
  }

  // Get project root path (for development/debugging)
  String get projectRoot {
    // This will work in debug mode
    // In production, you might want to use a different approach
    final currentDir = Directory.current.path;
    return currentDir;
  }

  // Get app documents directory path
  String get appDocumentsPath {
    if (_appDocumentsPath == null) {
      throw Exception('PathService not initialized. Call onInit first.');
    }
    return _appDocumentsPath!;
  }

  // Get app cache directory path
  String get appCachePath {
    if (_appCachePath == null) {
      throw Exception('PathService not initialized. Call onInit first.');
    }
    return _appCachePath!;
  }

  // Get app support directory path
  String get appSupportPath {
    if (_appSupportPath == null) {
      throw Exception('PathService not initialized. Call onInit first.');
    }
    return _appSupportPath!;
  }

  // Get temp directory path
  String get tempPath {
    if (_tempPath == null) {
      throw Exception('PathService not initialized. Call onInit first.');
    }
    return _tempPath!;
  }

  // Create a file path in documents directory
  String getFilePath(String fileName) {
    return '$appDocumentsPath/$fileName';
  }

  // Create a file path in cache directory
  String getCacheFilePath(String fileName) {
    return '$appCachePath/$fileName';
  }

  // Create a directory if it doesn't exist
  Future<Directory> ensureDirectory(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }
}

