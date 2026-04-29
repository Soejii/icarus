import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/konseling_repository.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListKonselingUsecase {
  final KonselingRepository _repository;
  GetListKonselingUsecase(this._repository);

  Future<Result<List<KonselingEntity>>> getListKonseling({
    required KonselingType type,
    int page = 1,
  }) {
    return _repository.getListKonseling(type: type, page: page);
  }
}
