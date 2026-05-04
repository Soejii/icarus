import 'package:icarus/features/rapor/domain/entities/rapor_period_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class RaporRepository {
  Future<Result<List<RaporPeriodEntity>>> getHistory({
    required int studentId,
    int page = 1,
  });
}
