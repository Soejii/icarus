import 'package:icarus/features/schedule/data/datasource/schedule_remote_data_source.dart';
import 'package:icarus/features/schedule/data/mappers/schedule_mapper.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/features/schedule/domain/schedule_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  const ScheduleRepositoryImpl(this._dataSource);

  final ScheduleRemoteDataSource _dataSource;

  @override
  Future<Result<List<ScheduleEntity>>> getScheduleByDay(DayOfWeek day, int studentId) =>
      guard(() async {
        final models = await _dataSource.getScheduleByDay(day, studentId);
        return models.map((model) => model.toEntity()).toList();
      });
}
