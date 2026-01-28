import 'package:gaia/features/balances/domain/type/transaction_status.dart';
import 'package:gaia/features/balances/domain/type/transaction_type.dart';

class SavingsHistoryEntity {
  final int id;
  final String? date;
  final int? amount;
  final TransactionStatus status;
  final TransactionType type;

  SavingsHistoryEntity({
    required this.id,
    this.date,
    this.amount,
    required this.status,
    required this.type,
  });
}
