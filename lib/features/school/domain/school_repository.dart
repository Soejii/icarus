import 'package:icarus/features/school/domain/entities/school_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class SchoolRepository {
  Future<Result<SchoolEntity>> getSchool();
}
