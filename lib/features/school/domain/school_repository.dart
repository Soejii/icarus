import 'package:gaia/features/school/domain/entities/school_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class SchoolRepository {
  Future<Result<SchoolEntity>> getSchool();
}
