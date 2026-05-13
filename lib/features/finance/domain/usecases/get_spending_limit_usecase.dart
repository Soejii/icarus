import 'package:icarus/features/finance/domain/entities/spending_limit_entity.dart';
import 'package:icarus/features/finance/domain/repositories/saving_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetSpendingLimitUsecase {
  final SavingRepository _repository;
  GetSpendingLimitUsecase(this._repository);

  Future<Result<SpendingLimitEntity>> call(int studentId) =>
      _repository.getSpendingLimit(studentId);
}
