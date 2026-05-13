import 'package:icarus/features/finance/domain/entities/saving_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/domain/entities/spending_limit_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class SavingRepository {
  Future<Result<SavingDetailEntity>> getSavingDetail(int studentId);

  Future<Result<List<SavingTransactionEntity>>> getSavingHistory(
      int studentId, {int limit = 20, int offset = 0});

  Future<Result<SavingTransactionEntity>> getSavingTransactionDetail(int id);

  Future<Result<SpendingLimitEntity>> getSpendingLimit(int studentId);

  Future<Result<void>> setSpendingLimit(
      int studentId, String type, int? amount);
}
