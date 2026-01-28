import '../../domain/entities/savings_history_entity.dart';
import '../models/savings_history_model.dart';
import 'package:gaia/features/balances/domain/type/transaction_status.dart';
import 'package:gaia/features/balances/domain/type/transaction_type.dart';

extension SavingsHistoryMapper on SavingsHistoryModel {
  SavingsHistoryEntity toEntity() => SavingsHistoryEntity(
        id: id,
        date: date,
        amount: amount,
        status: getTransactionStatus(),
        type: getTransactionType(),
      );

  TransactionType getTransactionType() {
    switch (transaction?.toLowerCase()) {
      case 'topup':
        return TransactionType.topup;
      case 'cashout':
        return TransactionType.cashout;
      default:
        return TransactionType.unknown;
    }
  }

  TransactionStatus getTransactionStatus() {
    switch (confirmed) {
      case 1:
        return TransactionStatus.success;
      case 0:
        return TransactionStatus.failed;
      default:
        return TransactionStatus.unknown;
    }
  }
}
