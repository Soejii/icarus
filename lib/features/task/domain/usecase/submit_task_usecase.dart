import 'dart:io';

import 'package:gaia/features/task/domain/task_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class SubmitTaskUsecase {
  final TaskRepository _repository;
  SubmitTaskUsecase(this._repository);

  Future<Result<Unit>> submitTask(int taskId, File file, String note) async {
    return await _repository.submitTask(taskId, file, note);
  }
}
