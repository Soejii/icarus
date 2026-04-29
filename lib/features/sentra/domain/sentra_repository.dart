import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class SentraRepository {
  Future<Result<List<SentraEntity>>> getListSentra({
    required int studentId,
    int page = 1,
  });
}
