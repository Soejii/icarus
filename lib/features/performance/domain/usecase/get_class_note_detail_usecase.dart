import 'package:icarus/features/performance/domain/entities/class_note_detail_entity.dart';
import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetClassNoteDetailUsecase {
  final PerformanceRepository _repository;

  GetClassNoteDetailUsecase(this._repository);

  Future<Result<ClassNoteDetailEntity>> getClassNoteDetail({
    required int noteId,
    required int idStudent,
  }) =>
      _repository.getClassNoteDetail(noteId: noteId, idStudent: idStudent);
}
