import 'package:gaia/features/schedule/domain/entities/schedule_entity.dart';
import 'package:gaia/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_controller.g.dart';

@riverpod
class ScheduleController extends _$ScheduleController {
  @override
  Future<List<ScheduleEntity>> build(DayOfWeek dayOfWeek) async {
    ref.keepAlive();
    final useCase = ref.read(getScheduleByDayUseCaseProvider);
    final result = await useCase.call(dayOfWeek);

    return result.fold(
      (failure) => throw failure,
      (schedules) => schedules,
    );
  }


  Future<void> refresh(DayOfWeek dayOfWeek) async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> fetchScheduleByDay(DayOfWeek dayOfWeek) async {
    ref.invalidateSelf();
    await future;
  }
}