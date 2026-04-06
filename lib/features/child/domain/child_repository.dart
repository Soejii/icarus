import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class ChildRepository {
  Future<Result<List<ChildEntity>>> getChildren();
}
