import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetStudentNoteDetailUsecase {
  final PerformanceRepository _repository;

  GetStudentNoteDetailUsecase(this._repository);

  Future<Result<NoteEntity>> getStudentNoteDetail({required int noteId}) =>
      _repository.getStudentNoteDetail(noteId: noteId);
}
