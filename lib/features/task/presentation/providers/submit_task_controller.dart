import 'dart:io';

import 'package:gaia/features/activity/presentation/providers/task_controller.dart';
import 'package:gaia/features/task/presentation/providers/task_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gaia/shared/core/types/result.dart';

part 'submit_task_controller.g.dart';

@riverpod
class SubmitTaskController extends _$SubmitTaskController {
  @override
  Future<void> build(int taskId) async {}

  Future<Result<Unit>> submitTask(
    File file,
    String note,
  ) async {
    state = const AsyncLoading();

    late final Result<Unit> result;

    final usecase = ref.read(submitTaskUsecaseProvider);
    result = await usecase.submitTask(taskId, file, note);
    ref.read(taskControllerProvider.notifier).refresh();

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
    return result;
  }
}
