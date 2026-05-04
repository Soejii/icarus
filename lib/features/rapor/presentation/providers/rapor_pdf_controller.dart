import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rapor_pdf_controller.g.dart';

const _raporCacheFolder = 'rapor_cache';

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
  CancelToken? _cancelToken;

  @override
  RaporPdfState build(String fileUrl, String suggestedFileName) {
    ref.onDispose(() {
      _cancelToken?.cancel('disposed');
    });
    _start(fileUrl, suggestedFileName);
    return const RaporPdfState();
  }

  Future<void> _start(String fileUrl, String suggestedFileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${dir.path}/$_raporCacheFolder');
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
      _cancelToken?.cancel('restart');
      _cancelToken = CancelToken();
      final tempPath = '$path.download';
      final tempFile = File(tempPath);
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
      await dio.download(
        fileUrl,
        tempPath,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            state = RaporPdfState(progress: received / total);
          }
        },
      );
      if (await file.exists()) {
        await file.delete();
      }
      await tempFile.rename(path);
      state = RaporPdfState(progress: 1, localPath: path);
    } on DioException catch (e) {
      await _deleteTempDownload(suggestedFileName);
      if (CancelToken.isCancel(e)) return;
      state = RaporPdfState(error: e);
    } catch (e) {
      await _deleteTempDownload(suggestedFileName);
      state = RaporPdfState(error: e);
    }
  }

  Future<void> retry(String fileUrl, String suggestedFileName) async {
    _cancelToken?.cancel('retry');
    state = const RaporPdfState();
    await _start(fileUrl, suggestedFileName);
  }

  Future<void> _deleteTempDownload(String suggestedFileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final safeName = suggestedFileName.replaceAll(
      RegExp(r'[^a-zA-Z0-9._-]'),
      '_',
    );
    final tempFile = File('${dir.path}/$_raporCacheFolder/$safeName.download');
    if (await tempFile.exists()) {
      await tempFile.delete();
    }
  }
}
