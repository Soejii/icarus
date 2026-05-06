import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/presentation/providers/performance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_note_detail_controller.g.dart';

@riverpod
class StudentNoteDetailController extends _$StudentNoteDetailController {
  @override
  Future<NoteEntity> build(int noteId) async {
    final uc = ref.watch(getStudentNoteDetailUsecaseProvider);
    final result = await uc.getStudentNoteDetail(noteId: noteId);
    return result.fold((e) => throw e, (entity) => entity);
  }
}
