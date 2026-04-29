import 'package:icarus/features/konseling/data/datasource/konseling_remote_data_source.dart';
import 'package:icarus/features/konseling/data/mappers/konseling_mapper.dart';
import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/konseling_repository.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class KonselingRepositoryImpl implements KonselingRepository {
  final KonselingRemoteDataSource _dataSource;
  KonselingRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<KonselingEntity>>> getListKonseling({
    required KonselingType type,
    int page = 1,
  }) =>
      guard(
        () async {
          final models =
              await _dataSource.getListKonseling(type.apiValue, page);
          return models.map((m) => m.toEntity(type)).toList();
        },
      );

  @override
  Future<Result<KonselingEntity>> getDetailKonseling({
    required KonselingType type,
    required int id,
  }) =>
      guard(
        () async {
          final model =
              await _dataSource.getDetailKonseling(type.apiValue, id);
          return model.toEntity();
        },
      );
}
