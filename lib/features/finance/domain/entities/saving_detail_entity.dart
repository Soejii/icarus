class SavingDetailEntity {
  final String studentName;
  final String? schoolName;
  final String? cardId;
  final int saldoTopup;
  final int totalTopup;
  final int totalCashout;
  final int totalTransaction;

  SavingDetailEntity({
    required this.studentName,
    this.schoolName,
    this.cardId,
    required this.saldoTopup,
    required this.totalTopup,
    required this.totalCashout,
    required this.totalTransaction,
  });
}
