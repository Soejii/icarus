import 'package:gaia/features/balances/domain/balance_repository.dart';
import 'package:gaia/features/balances/domain/entities/emoney_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetEmoneyBalanceUsecase {
  final BalanceRepository _repository;
  GetEmoneyBalanceUsecase(this._repository);

  Future<Result<EmoneyEntity>> getEmoneyBalance() async {
    return await _repository.getEmoneyBalance();
  }
}
