import 'package:gaia/features/balances/domain/balance_repository.dart';
import 'package:gaia/features/balances/domain/entities/emoney_history_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetEmoneyHistoryUsecase {
  final BalanceRepository _repository;

  GetEmoneyHistoryUsecase(this._repository);

  Future<Result<List<EmoneyHistoryEntity>>> getEmoneyHistory({int? page}) {
    return _repository.getEmoneyHistory(page: page);
  }
}
