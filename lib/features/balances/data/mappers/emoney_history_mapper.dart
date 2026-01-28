import '../../domain/entities/emoney_history_entity.dart';
import '../models/emoney_history_model.dart';
import 'package:gaia/features/balances/domain/type/transaction_status.dart';
import 'package:gaia/features/balances/domain/type/transaction_type.dart';

extension EmoneyHistoryMapper on EmoneyHistoryModel {
  EmoneyHistoryEntity toEntity() => EmoneyHistoryEntity(
        id: id,
        amount: amount,
        date: date,
        transactionType: getTransactionType(),
        status: getTransactionStatus(),
      );

  TransactionType getTransactionType() {
    switch (transaction?.toLowerCase()) {
      case 'topup':
        return TransactionType.topup;
      case 'cashout':
        return TransactionType.cashout;
      case 'bill_pay':
        return TransactionType.billPay;
      case 'canteen_pay':
        return TransactionType.canteenPay;
      default:
        return TransactionType.unknown;
    }
  }

  TransactionStatus getTransactionStatus() {
    switch (status?.toLowerCase()) {
      case 'success':
        return TransactionStatus.success;
      case 'pending':
        return TransactionStatus.pending;
      case 'failed':
        return TransactionStatus.failed;
      default:
        return TransactionStatus.unknown;
    }
  }
}