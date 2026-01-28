import 'package:icarus/features/school/data/datasource/school_remote_data_source.dart';
import 'package:icarus/features/school/data/mappers/school_mapper.dart';
import 'package:icarus/features/school/domain/entities/school_entity.dart';
import 'package:icarus/features/school/domain/school_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class SchoolRepositoryImpl implements SchoolRepository {
  final SchoolRemoteDataSource _dataSource;
  SchoolRepositoryImpl(this._dataSource);

  @override
  Future<Result<SchoolEntity>> getSchool() => guard(
        () async {
          final models = await _dataSource.getSchool();
          return models.toEntity();
        },
      );
}
