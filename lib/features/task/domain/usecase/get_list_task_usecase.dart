import 'package:gaia/shared/core/domain/entities/task_entity.dart';
import 'package:gaia/features/task/domain/task_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListTaskUsecase {
  final TaskRepository _repository;
  GetListTaskUsecase(this._repository);

  Future<Result<List<TaskEntity>>> getTasks({int? page}) async {
    return await _repository.getTasks(page: page);
  }
}
