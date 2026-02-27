import 'package:icarus/features/performance/domain/entities/student_note_entity.dart';
import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListStudentNotes {
  final PerformanceRepository _repository;
  GetListStudentNotes(this._repository);

  Future<Result<List<StudentNoteEntity>>> getListStudentNotes() async {
    return await _repository.getListStudentNote();
  }
}
