import 'package:icarus/features/edutainment/data/datasources/edutainment_remote_data_source.dart';
import 'package:icarus/features/edutainment/data/mappers/digital_magazine_mapper.dart';
import 'package:icarus/features/edutainment/data/mappers/edutainment_mapper.dart';
import 'package:icarus/features/edutainment/domain/edutainment_repository.dart';
import 'package:icarus/features/edutainment/domain/entities/digital_magazine_entity.dart';
import 'package:icarus/features/edutainment/domain/entities/edutainment_entity.dart';
import 'package:icarus/features/edutainment/domain/type/edutainment_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class EdutainmentRepositoryImpl implements EdutainmentRepository {
  final EdutainmentRemoteDataSource _dataSource;
  EdutainmentRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<EdutainmentEntity>>> getListEdutainment({
    required EdutainmentType type,
    int page = 1,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListEdutainment(type.label, page);
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<EdutainmentEntity>> getDetailEdutainment({required int id}) {
    return guard(
      () async {
        final model = await _dataSource.getDetailEdutainment(id);
        return model.toEntity();
      },
    );
  }

    @override
  Future<Result<List<DigitalMagazineEntity>>> getListDigitalMagazine() =>
      guard(
        () async {
          final models = await _dataSource.getListDigitalMagazine();
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );
}
