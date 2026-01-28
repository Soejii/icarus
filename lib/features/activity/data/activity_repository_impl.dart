import 'package:gaia/features/activity/data/datasources/activity_remote_data_source.dart';
import 'package:gaia/features/activity/data/mappers/exam_mapper.dart';
import 'package:gaia/features/activity/domain/activity_repository.dart';
import 'package:gaia/shared/core/domain/entities/exam_entity.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/shared/core/types/result.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource _dataSource;
  ActivityRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<ExamEntity>>> getExam(ExamType type, {int? page}) => guard(
        () async {
          final models = await _dataSource.getExam(type.name, page ?? 1);
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  // @override
  // Future<Result<List<TaskEntity>>> getTasks({int? page}) => guard(
  //       () async {
  //         final models = await _dataSource.getTasks(page ?? 1);
  //         return models
  //             .map(
  //               (model) => model.toEntity(),
  //             )
  //             .toList();
  //       },
  //     );
}
