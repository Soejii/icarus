import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/shared/core/domain/entities/exam_entity.dart';
import 'package:icarus/shared/core/domain/types/exam_type.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class PerformanceRepository {
  Future<Result<List<ExamEntity>>> getListExam({
    required int idStudent,
    required int page,
    required ExamType examType,
  });
  Future<Result<List<NoteEntity>>> getListStudentNote({
    required int idStudent,
    required int page,
  });
    Future<Result<List<NoteEntity>>> getListClassNote({
    required int idStudent,
    required int page,
  });
}
