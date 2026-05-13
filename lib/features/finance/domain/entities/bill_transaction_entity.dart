import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';

class BillTransactionEntity {
  final int id;
  final String billName;
  final int billAmount;
  final int beforeDiscount;
  final BillCategoryType category;
  final BillStatusType status;
  final int paidAmount;
  final String? payMethod;
  final String? evidencePath;
  final int discount;
  final String? notes;
  final DateTime? payDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? month;
  final bool isInstallment;

  BillTransactionEntity({
    required this.id,
    required this.billName,
    required this.billAmount,
    required this.beforeDiscount,
    required this.category,
    required this.status,
    required this.paidAmount,
    this.payMethod,
    this.evidencePath,
    required this.discount,
    this.notes,
    this.payDate,
    this.startDate,
    this.endDate,
    this.month,
    required this.isInstallment,
  });
}
