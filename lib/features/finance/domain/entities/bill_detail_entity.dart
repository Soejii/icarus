import 'package:icarus/features/finance/domain/entities/bill_installment_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';

class BillDetailEntity {
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
  final String studentName;
  final String studentNis;
  final String studentClass;
  final List<BillInstallmentEntity> installmentsConfirmed;
  final BillInstallmentEntity? pendingInstallment;
  final String? latestTransactionRedirectUrl;
  final String? latestTransactionVirtualAccount;
  final String? latestTransactionTrxId;
  final String? latestTransactionStatus;
  final int? latestTransactionAmount;

  BillDetailEntity({
    required this.id,
    required this.billName,
    required this.billAmount,
    required this.beforeDiscount,
    required this.category,
    required this.status,
    required this.paidAmount,
    required this.payMethod,
    required this.evidencePath,
    required this.discount,
    required this.notes,
    required this.payDate,
    required this.startDate,
    required this.endDate,
    required this.month,
    required this.isInstallment,
    required this.studentName,
    required this.studentNis,
    required this.studentClass,
    required this.installmentsConfirmed,
    required this.pendingInstallment,
    required this.latestTransactionRedirectUrl,
    required this.latestTransactionVirtualAccount,
    required this.latestTransactionTrxId,
    required this.latestTransactionStatus,
    required this.latestTransactionAmount,
  });
}
