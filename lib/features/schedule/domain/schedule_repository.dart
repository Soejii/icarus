import 'package:gaia/features/schedule/domain/entities/schedule_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class ScheduleRepository {
  Future<Result<List<ScheduleEntity>>>  getScheduleByDay(DayOfWeek dayOfWeek);
}

