import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class RaporFileDataSource {
  static const _downloadsChannel = MethodChannel('icarus/downloads');

  Future<String> savePdfToDevice({
    required String sourcePath,
    required String suggestedFileName,
  }) async {
    final fileName = suggestedFileName.replaceAll(
      RegExp(r'[^a-zA-Z0-9._-]'),
      '_',
    );

    if (Platform.isAndroid) {
      final path = await _downloadsChannel.invokeMethod<String>(
        'savePdfToDownloads',
        {
          'fileName': fileName,
          'sourcePath': sourcePath,
        },
      );
      if (path == null || path.isEmpty) {
        throw StateError('Failed to save file to Downloads');
      }
      return path;
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final raporDir = Directory('${docsDir.path}/Rapor');
    if (!await raporDir.exists()) {
      await raporDir.create(recursive: true);
    }
    final destPath = await availableFilePath(raporDir.path, fileName);
    await File(sourcePath).copy(destPath);
    return destPath;
  }

  Future<String> availableFilePath(
      String directoryPath, String fileName) async {
    var path = '$directoryPath/$fileName';
    if (!await File(path).exists()) return path;

    final dotIndex = fileName.lastIndexOf('.');
    final name = dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;
    final extension = dotIndex > 0 ? fileName.substring(dotIndex) : '';
    var index = 1;
    do {
      path = '$directoryPath/$name ($index)$extension';
      index++;
    } while (await File(path).exists());
    return path;
  }
}
