import 'package:gaia/features/activity/data/mappers/exam_mapper.dart';
import 'package:gaia/features/task/data/mapper/task_mapper.dart';
import 'package:gaia/shared/core/domain/entities/exam_entity.dart';
import 'package:gaia/shared/core/domain/entities/task_entity.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/features/subject/data/datasources/subject_remote_data_source.dart';
import 'package:gaia/features/subject/data/mapper/detail_sub_module_mapper.dart';
import 'package:gaia/features/subject/data/mapper/media_mapper.dart';
import 'package:gaia/features/subject/data/mapper/module_mapper.dart';
import 'package:gaia/features/subject/data/mapper/subject_mapper.dart';
import 'package:gaia/features/subject/domain/entities/detail_sub_module_entity.dart';
import 'package:gaia/features/subject/domain/entities/media_entity.dart';
import 'package:gaia/features/subject/domain/entities/module_entity.dart';
import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectRemoteDataSource _dataSource;
  SubjectRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<SubjectEntity>>> getAllSubject() => guard(
        () async {
          final models = await _dataSource.getAllSubject();
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<List<ModuleEntity>>> getListModule(int subjectId) => guard(
        () async {
          final models = await _dataSource.getModule(subjectId);
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<List<MediaEntity>>> getListMedia(int subjectId) => guard(
        () async {
          final models = await _dataSource.getLearningMedia(subjectId);
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<List<ExamEntity>>> getListExam(
    int subjectId,
    ExamType examType,
    {int? page}
  ) =>
      guard(
        () async {
          final models = await _dataSource.getListSubjectExam(
            subjectId,
            examType,
            page ?? 1
          );
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<List<TaskEntity>>> getListTask(int subjectId, {int? page}) =>
      guard(
        () async {
          final models = await _dataSource.getListTask(
            subjectId,
            page ?? 1,
          );
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<DetailSubModuleEntity>> getDetailSubModule(int subModuleId) =>
      guard(
        () async {
          final model = await _dataSource.getDetailSubModule(subModuleId);
          return model.toEntity();
        },
      );

  @override
  Future<Result<SubjectEntity>> getDetailSubject(int subjectId) => guard(
        () async {
          final model = await _dataSource.getDetailSubject(subjectId);
          return model.toEntity();
        },
      );
}
