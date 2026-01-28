import 'package:gaia/features/school/domain/entities/school_entity.dart';
import 'package:gaia/features/school/domain/school_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetSchoolUseCase {
  final SchoolRepository _repository;
  GetSchoolUseCase(this._repository);

  Future<Result<SchoolEntity>> getSchool() {
    return _repository.getSchool();
  }
}
