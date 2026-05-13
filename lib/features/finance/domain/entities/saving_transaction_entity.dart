class SavingTransactionEntity {
  final int id;
  final int amount;
  final String? notes;
  final String type;
  final bool confirmed;
  final String transaction;
  final DateTime? date;
  final String? confirmationPhoto;
  final String? receivedBy;
  final String? givenBy;

  SavingTransactionEntity({
    required this.id,
    required this.amount,
    required this.notes,
    required this.type,
    required this.confirmed,
    required this.transaction,
    required this.date,
    required this.confirmationPhoto,
    required this.receivedBy,
    required this.givenBy,
  });
}
