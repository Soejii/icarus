import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class TahfidzTahsinRepository {
  Future<Result<List<TahfidzRecord>>> getListTahfidz({
    required int studentId,
    int page = 1,
  });

  Future<Result<List<TahsinRecord>>> getListTahsin({
    required int studentId,
    int page = 1,
  });
}
