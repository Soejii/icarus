import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListStudentNotesUsecase {
  final PerformanceRepository _repository;
  GetListStudentNotesUsecase(this._repository);

  Future<Result<List<NoteEntity>>> getListStudentNotes({
    required int idStudent,
    required int page,
  }) async {
    return await _repository.getListStudentNote(
      idStudent: idStudent,
      page: page,
    );
  }
}
