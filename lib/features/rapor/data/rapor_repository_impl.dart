import 'package:icarus/features/rapor/data/datasource/rapor_remote_data_source.dart';
import 'package:icarus/features/rapor/data/mappers/rapor_mapper.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_period_entity.dart';
import 'package:icarus/features/rapor/domain/rapor_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class RaporRepositoryImpl implements RaporRepository {
  final RaporRemoteDataSource _dataSource;

  const RaporRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<RaporPeriodEntity>>> getHistory({
    required int studentId,
    int page = 1,
  }) =>
      guard(() async {
        final models =
            await _dataSource.getHistory(studentId: studentId, page: page);
        return models
            .map(
              (model) => model.toEntity(),
            )
            .toList(growable: false);
      });
}
