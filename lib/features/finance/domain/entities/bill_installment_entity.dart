import 'package:icarus/features/finance/domain/types/bill_status_type.dart';

class BillInstallmentEntity {
  final int id;
  final DateTime? payDate;
  final int payAmount;
  final String payMethod;
  final BillStatusType status;

  BillInstallmentEntity({
    required this.id,
    this.payDate,
    required this.payAmount,
    required this.payMethod,
    required this.status,
  });
}
