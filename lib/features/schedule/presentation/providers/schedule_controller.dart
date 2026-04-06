import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_controller.g.dart';

@Riverpod(keepAlive: true)
class ScheduleController extends _$ScheduleController {
  @override
  Future<List<ScheduleEntity>> build(DayOfWeek day) async {
    final usecase = ref.read(getScheduleByDayUsecaseProvider);
    final result = await usecase.call(day);
    return result.fold(
      (failure) => throw failure,
      (entities) => entities,
    );
  }
}
