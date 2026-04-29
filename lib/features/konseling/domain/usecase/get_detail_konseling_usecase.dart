import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/konseling_repository.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetDetailKonselingUsecase {
  final KonselingRepository _repository;
  GetDetailKonselingUsecase(this._repository);

  Future<Result<KonselingEntity>> getDetailKonseling({
    required KonselingType type,
    required int id,
  }) {
    return _repository.getDetailKonseling(type: type, id: id);
  }
}
