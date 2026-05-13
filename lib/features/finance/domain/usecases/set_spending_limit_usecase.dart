import 'package:icarus/features/finance/domain/repositories/saving_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class SetSpendingLimitUsecase {
  final SavingRepository _repository;
  SetSpendingLimitUsecase(this._repository);

  Future<Result<void>> call(int studentId, String type, int? amount) =>
      _repository.setSpendingLimit(studentId, type, amount);
}
