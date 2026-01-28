import 'package:gaia/features/schedule/domain/entities/schedule_entity.dart';
import 'package:gaia/features/schedule/domain/schedule_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetScheduleByDayUsecase {
  final ScheduleRepository repository;

  const GetScheduleByDayUsecase(this.repository);
  Future<Result<List<ScheduleEntity>>> call(DayOfWeek dayOfWeek) async {
    return await repository.getScheduleByDay(dayOfWeek);
  }
}
