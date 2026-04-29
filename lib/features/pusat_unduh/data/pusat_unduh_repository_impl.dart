import 'package:icarus/features/pusat_unduh/data/datasource/pusat_unduh_remote_data_source.dart';
import 'package:icarus/features/pusat_unduh/data/mappers/pusat_unduh_mapper.dart';
import 'package:icarus/features/pusat_unduh/domain/entities/pusat_unduh_entity.dart';
import 'package:icarus/features/pusat_unduh/domain/pusat_unduh_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class PusatUnduhRepositoryImpl implements PusatUnduhRepository {
  final PusatUnduhRemoteDataSource _dataSource;
  PusatUnduhRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<PusatUnduhEntity>>> getListPusatUnduh({
    int page = 1,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListPusatUnduh(page);
          return models.map((m) => m.toEntity()).toList();
        },
      );
}
