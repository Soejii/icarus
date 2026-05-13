import 'package:icarus/features/finance/domain/entities/saving_detail_entity.dart';
import 'package:icarus/features/finance/domain/repositories/saving_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetSavingDetailUsecase {
  final SavingRepository _repository;
  GetSavingDetailUsecase(this._repository);

  Future<Result<SavingDetailEntity>> call(int studentId) =>
      _repository.getSavingDetail(studentId);
}
