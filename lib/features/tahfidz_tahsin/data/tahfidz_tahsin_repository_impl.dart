import 'package:icarus/features/tahfidz_tahsin/data/datasource/tahfidz_tahsin_remote_data_source.dart';
import 'package:icarus/features/tahfidz_tahsin/data/mappers/tahfidz_tahsin_mapper.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/tahfidz_tahsin_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class TahfidzTahsinRepositoryImpl implements TahfidzTahsinRepository {
  final TahfidzTahsinRemoteDataSource _dataSource;
  TahfidzTahsinRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<TahfidzRecord>>> getListTahfidz({
    required int studentId,
    int page = 1,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListTahfidz(studentId, page);
          return models.map((m) => m.toEntity()).toList();
        },
      );

  @override
  Future<Result<List<TahsinRecord>>> getListTahsin({
    required int studentId,
    int page = 1,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListTahsin(studentId, page);
          return models.map((m) => m.toEntity()).toList();
        },
      );
}
