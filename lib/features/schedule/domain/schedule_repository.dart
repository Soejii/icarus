import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class ScheduleRepository {
  Future<Result<List<ScheduleEntity>>> getScheduleByDay(DayOfWeek day, int studentId);
}
