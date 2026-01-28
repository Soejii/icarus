import 'package:gaia/features/balances/domain/entities/emoney_entity.dart';
import 'package:gaia/features/balances/domain/entities/emoney_history_entity.dart';
import 'package:gaia/features/balances/domain/entities/savings_entity.dart';
import 'package:gaia/features/balances/domain/entities/savings_history_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class BalanceRepository {
  Future<Result<EmoneyEntity>> getEmoneyBalance();
  Future<Result<SavingsEntity>> getSavingsBalance();
  Future<Result<List<EmoneyHistoryEntity>>> getEmoneyHistory({int? page});
  Future<Result<List<SavingsHistoryEntity>>> getSavingsHistory({int? page});
}
