import 'package:gaia/shared/core/domain/entities/exam_entity.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class ActivityRepository {
  Future<Result<List<ExamEntity>>> getExam(ExamType type, {int? page});
  // Future<Result<List<TaskEntity>>> getTasks({int? page});
}
