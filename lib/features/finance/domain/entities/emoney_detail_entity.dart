class EmoneyDetailEntity {
  final String studentName;
  final String? schoolName;
  final String? cardId;
  final int saldoEmoney;
  final int totalTopup;
  final int totalPayment;
  final int totalCashout;
  final int totalTransaction;

  EmoneyDetailEntity({
    required this.studentName,
    required this.schoolName,
    required this.cardId,
    required this.saldoEmoney,
    required this.totalTopup,
    required this.totalPayment,
    required this.totalCashout,
    required this.totalTransaction,
  });
}
