import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/subject/domain/entities/detail_sub_module_entity.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

part 'detail_sub_module_controller.g.dart';

@riverpod
class DetailSubModuleController extends _$DetailSubModuleController {
  Timer? _ttl; // for optional TTL keepAlive
  KeepAliveLink? _link;
  @override
  Future<DetailSubModuleEntity> build(int idSubModule) {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());
    return _fetch(idSubModule);
  }

  Future<DetailSubModuleEntity> _fetch(int idSubModule) async {
    final useCase = ref.read(getDetailSubModuleUsecaseProvider);
    final res = await useCase.getDetailSubModule(idSubModule);

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }

  Future<void> refresh(int idSubModule) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(idSubModule));
  }

  Future<bool> downloadPdf(PdfViewerController pdfController) async {
    if (pdfController.pageCount == 0) return false;

    final bytes = await pdfController.saveDocument();
    final title = state.valueOrNull?.title;
    final fileName = '${title ?? 'document'}.pdf';

    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      bytes:  Uint8List.fromList(bytes), // Add this - FilePicker handles the writing on mobile
    );

    return result != null;
  }
}
