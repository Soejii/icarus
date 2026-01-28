import 'package:icarus/features/school/domain/entities/school_entity.dart';
import 'package:icarus/features/school/domain/school_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetSchoolUseCase {
  final SchoolRepository _repository;
  GetSchoolUseCase(this._repository);

  Future<Result<SchoolEntity>> getSchool() {
    return _repository.getSchool();
  }
}
