import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class KonselingRepository {
  Future<Result<List<KonselingEntity>>> getListKonseling({
    required KonselingType type,
    int page = 1,
  });

  Future<Result<KonselingEntity>> getDetailKonseling({
    required KonselingType type,
    required int id,
  });
}
