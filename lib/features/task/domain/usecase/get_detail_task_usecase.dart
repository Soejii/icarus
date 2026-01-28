import 'package:gaia/features/task/domain/entities/detail_task_entity.dart';
import 'package:gaia/features/task/domain/task_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetDetailTaskUsecase {
  final TaskRepository _repository;
  GetDetailTaskUsecase(this._repository);

  Future<Result<DetailTaskEntity>> getDetailTask(int id) async {
    return await _repository.getDetailTask(id);
  }
}
