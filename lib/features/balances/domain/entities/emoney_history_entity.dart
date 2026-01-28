import 'package:gaia/features/balances/domain/type/transaction_status.dart';
import 'package:gaia/features/balances/domain/type/transaction_type.dart';

class EmoneyHistoryEntity {
  final int id;
  final String? amount;
  final String? date;
  final TransactionType transactionType;
  final TransactionStatus status;

  EmoneyHistoryEntity({
    required this.id,
    this.amount,
    this.date,
    required this.transactionType,
    required this.status,
  });
}

