import 'package:gaia/features/balances/domain/balance_repository.dart';
import 'package:gaia/features/balances/domain/entities/savings_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetSavingsBalanceUsecase {
  final BalanceRepository _repository;
  GetSavingsBalanceUsecase(this._repository);

  Future<Result<SavingsEntity>> getSavingsBalance() async {
    return await _repository.getSavingsBalance();
  }
}
