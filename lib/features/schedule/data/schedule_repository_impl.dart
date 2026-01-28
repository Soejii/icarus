import 'package:gaia/features/schedule/data/datasource/schedule_remote_datasource.dart';
import 'package:gaia/features/schedule/data/mappers/schedule_mapper.dart';
import 'package:gaia/features/schedule/domain/entities/schedule_entity.dart';
import 'package:gaia/features/schedule/domain/schedule_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource _dataSource;
  ScheduleRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<ScheduleEntity>>> getScheduleByDay(DayOfWeek dayOfWeek) => guard(
        () async {
          final dayString = _getDayString(dayOfWeek);
          final models = await _dataSource.getScheduleByDay(dayString);
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  String _getDayString(DayOfWeek dayOfWeek) {
    switch (dayOfWeek) {
      case DayOfWeek.monday:
        return 'senin';
      case DayOfWeek.tuesday:
        return 'selasa';
      case DayOfWeek.wednesday:
        return 'rabu';
      case DayOfWeek.thursday:
        return 'kamis';
      case DayOfWeek.friday:
        return 'jumat';
      case DayOfWeek.saturday:
        return 'sabtu';
      case DayOfWeek.sunday:
        return 'minggu';
    }
  }
}



