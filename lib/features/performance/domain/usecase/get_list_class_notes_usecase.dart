import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListClassNotesUsecase {
  final PerformanceRepository _repository;
  GetListClassNotesUsecase(this._repository);

  Future<Result<List<NoteEntity>>> getListClassNotes({
    required int idStudent,
    required int page,
  }) async {
    return await _repository.getListClassNote(
      idStudent: idStudent,
      page: page,
    );
  }
}
