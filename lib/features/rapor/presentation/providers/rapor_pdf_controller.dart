import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rapor_pdf_controller.g.dart';

class RaporPdfState {
  const RaporPdfState({this.progress = 0, this.localPath, this.error});

  final double progress;
  final String? localPath;
  final Object? error;

  bool get isDownloading => localPath == null && error == null;
  bool get isReady => localPath != null;
  bool get isError => error != null;
}

@riverpod
class RaporPdfController extends _$RaporPdfController {
  @override
  RaporPdfState build(String fileUrl, String suggestedFileName) {
    _start(fileUrl, suggestedFileName);
    return const RaporPdfState();
  }

  Future<void> _start(String fileUrl, String suggestedFileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${dir.path}/rapor_cache');
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }
      final safeName = suggestedFileName.replaceAll(
        RegExp(r'[^a-zA-Z0-9._-]'),
        '_',
      );
      final path = '${cacheDir.path}/$safeName';
      final file = File(path);
      if (await file.exists()) {
        state = RaporPdfState(progress: 1, localPath: path);
        return;
      }

      final dio = Dio();
      await dio.download(
        fileUrl,
        path,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            state = RaporPdfState(progress: received / total);
          }
        },
      );
      state = RaporPdfState(progress: 1, localPath: path);
    } catch (e) {
      state = RaporPdfState(error: e);
    }
  }

  Future<void> retry(String fileUrl, String suggestedFileName) async {
    state = const RaporPdfState();
    await _start(fileUrl, suggestedFileName);
  }
}
