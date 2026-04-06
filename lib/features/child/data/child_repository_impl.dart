import 'package:icarus/features/child/data/datasource/child_remote_datasource.dart';
import 'package:icarus/features/child/data/mappers/child_mapper.dart';
import 'package:icarus/features/child/domain/child_repository.dart';
import 'package:icarus/features/child/domain/entities/child_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class ChildRepositoryImpl implements ChildRepository {
  const ChildRepositoryImpl(this._dataSource);

  final ChildRemoteDataSource _dataSource;

  @override
  Future<Result<List<ChildEntity>>> getChildren() =>
      guard(() async {
        final models = await _dataSource.getChildren();
        return models.map((m) => m.toEntity()).toList();
      });
}
