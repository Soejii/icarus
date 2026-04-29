import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/features/schedule/domain/schedule_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetScheduleByDayUsecase {
  const GetScheduleByDayUsecase(this._repository);

  final ScheduleRepository _repository;

  Future<Result<List<ScheduleEntity>>> getScheduleByDay(
    DayOfWeek day,
    int studentId,
  ) =>
      _repository.getScheduleByDay(day, studentId);
}
