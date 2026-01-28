import 'package:gaia/features/balances/domain/balance_repository.dart';
import 'package:gaia/features/balances/domain/entities/savings_history_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetSavingsHistoryUsecase {
  final BalanceRepository _repository;

  GetSavingsHistoryUsecase(this._repository);

  Future<Result<List<SavingsHistoryEntity>>> getSavingsHistory({int? page}) {
    return _repository.getSavingsHistory(page: page);
  }
}
