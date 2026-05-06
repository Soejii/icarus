import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/performance/domain/entities/class_note_detail_entity.dart';
import 'package:icarus/features/performance/presentation/providers/performance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'class_note_detail_controller.g.dart';

@riverpod
class ClassNoteDetailController extends _$ClassNoteDetailController {
  @override
  Future<ClassNoteDetailEntity> build(int noteId) async {
    final studentId = ref.watch(selectedChildProvider)?.id ?? 0;
    final uc = ref.watch(getClassNoteDetailUsecaseProvider);
    final result = await uc.getClassNoteDetail(
      noteId: noteId,
      idStudent: studentId,
    );
    return result.fold((e) => throw e, (entity) => entity);
  }
}
