import 'package:icarus/features/finance/domain/entities/emoney_detail_entity.dart';
import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetEmoneyDetailUsecase {
  final EmoneyRepository _repository;
  GetEmoneyDetailUsecase(this._repository);

  Future<Result<EmoneyDetailEntity>> call(int studentId) =>
      _repository.getEmoneyDetail(studentId);
}
