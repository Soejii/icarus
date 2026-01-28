import 'package:gaia/shared/core/domain/entities/exam_entity.dart';
import 'package:gaia/shared/core/domain/entities/task_entity.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/features/subject/domain/entities/detail_sub_module_entity.dart';
import 'package:gaia/features/subject/domain/entities/media_entity.dart';
import 'package:gaia/features/subject/domain/entities/module_entity.dart';
import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class SubjectRepository {
  Future<Result<List<SubjectEntity>>> getAllSubject();
  Future<Result<List<ModuleEntity>>> getListModule(int subjectId);
  Future<Result<List<MediaEntity>>> getListMedia(int subjectId);
  Future<Result<List<ExamEntity>>> getListExam(int subjectId, ExamType type, {int? page});
  Future<Result<List<TaskEntity>>> getListTask(int subjectId, {int? page});
  Future<Result<DetailSubModuleEntity>> getDetailSubModule(int subModuleId);
  Future<Result<SubjectEntity>> getDetailSubject(int subjectId);
}
