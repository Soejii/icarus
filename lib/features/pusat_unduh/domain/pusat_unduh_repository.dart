import 'package:icarus/features/pusat_unduh/domain/entities/pusat_unduh_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class PusatUnduhRepository {
  Future<Result<List<PusatUnduhEntity>>> getListPusatUnduh({int page = 1});
}
