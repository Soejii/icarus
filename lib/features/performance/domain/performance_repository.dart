import 'package:icarus/features/performance/domain/entities/student_note_entity.dart';
import 'package:icarus/shared/core/domain/entities/exam_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class PerformanceRepository {
  Future<Result<List<ExamEntity>>> getListExam();
  Future<Result<List<StudentNoteEntity>>> getListStudentNote();
}
