import 'package:icarus/features/finance/domain/entities/canteen_item_entity.dart';

class EmoneyTransactionEntity {
  final int id;
  final int amount;
  final bool isDebit;
  final String? notes;
  final String type;
  final String transaction;
  final String status;
  final DateTime? date;
  final String? confirmationPhoto;
  final String? merchantName;
  final List<CanteenItemEntity> canteenItems;
  final String? studentName;
  final String? studentNis;

  EmoneyTransactionEntity({
    required this.id,
    required this.amount,
    required this.isDebit,
    this.notes,
    required this.type,
    required this.transaction,
    required this.status,
    this.date,
    this.confirmationPhoto,
    this.merchantName,
    required this.canteenItems,
    this.studentName,
    this.studentNis,
  });
}
