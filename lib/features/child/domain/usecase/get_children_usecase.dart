import 'package:icarus/features/child/domain/child_repository.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetChildrenUsecase {
  const GetChildrenUsecase(this._repository);

  final ChildRepository _repository;

  Future<Result<List<ChildEntity>>> call() => _repository.getChildren();
}
