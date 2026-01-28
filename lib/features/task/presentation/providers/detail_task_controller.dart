import 'package:gaia/features/task/domain/entities/detail_task_entity.dart';
import 'package:gaia/features/task/presentation/providers/task_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_task_controller.g.dart';

@riverpod
class DetailTaskController extends _$DetailTaskController {
    @override
  Future<DetailTaskEntity> build(int idTask) async {
    final usecase = ref.read(getDetailTaskUsecaseProvider);
    final res = await usecase.getDetailTask(idTask);

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }
}