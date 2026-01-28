import 'dart:io';

import 'package:gaia/features/task/domain/entities/detail_task_entity.dart';
import 'package:gaia/shared/core/domain/entities/task_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class TaskRepository {
  Future<Result<List<TaskEntity>>> getTasks({int? page});
  Future<Result<DetailTaskEntity>> getDetailTask(int id);
  Future<Result<Unit>> submitTask(int idTask, File file, String note);
}
