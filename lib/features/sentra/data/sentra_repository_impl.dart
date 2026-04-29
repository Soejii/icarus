import 'package:icarus/features/sentra/data/datasource/sentra_remote_data_source.dart';
import 'package:icarus/features/sentra/data/mappers/sentra_mapper.dart';
import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/features/sentra/domain/sentra_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class SentraRepositoryImpl implements SentraRepository {
  final SentraRemoteDataSource _dataSource;
  SentraRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<SentraEntity>>> getListSentra({
    required int studentId,
    int page = 1,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListSentra(studentId, page);
          return models.map((m) => m.toEntity()).toList();
        },
      );
}
