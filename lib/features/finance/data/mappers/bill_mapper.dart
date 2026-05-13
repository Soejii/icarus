import 'package:icarus/features/finance/data/models/bill_detail_model.dart';
import 'package:icarus/features/finance/data/models/bill_transaction_model.dart';
import 'package:icarus/features/finance/data/models/no_rekening_model.dart';
import 'package:icarus/features/finance/data/models/payment_method_model.dart';
import 'package:icarus/features/finance/domain/entities/bank_transfer_info_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_installment_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/entities/payment_method_entity.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/domain/types/bill_status_type.dart';
import 'package:icarus/shared/core/utils/safe_date_parser.dart';

extension BillTransactionMapper on BillTransactionModel {
  BillTransactionEntity toEntity() {
    return BillTransactionEntity(
      id: id,
      billName: bill.name,
      billAmount: bill.amount,
      beforeDiscount: bill.beforeDiscount,
      category: _mapCategory(bill.type),
      status: _mapStatus(status),
      paidAmount: payAmount,
      payMethod: payMethod,
      evidencePath: evidencePath,
      discount: discount,
      notes: notes,
      payDate: SafeDateParser.parse(payDate),
      startDate: SafeDateParser.parse(bill.startDate),
      endDate: SafeDateParser.parse(bill.endDate),
      month: _parseMonth(bill.month),
      isInstallment: bill.isInstallment == 1,
    );
  }
}

extension BillDetailMapper on BillDetailModel {
  BillDetailEntity toEntity() {
    return BillDetailEntity(
      id: id,
      billName: bill.name,
      billAmount: bill.amount,
      beforeDiscount: bill.beforeDiscount,
      category: _mapCategory(bill.type),
      status: _mapStatus(status),
      paidAmount: payAmount,
      payMethod: payMethod,
      evidencePath: evidencePath,
      discount: discount,
      notes: notes,
      payDate: SafeDateParser.parse(payDate),
      startDate: SafeDateParser.parse(bill.startDate),
      endDate: SafeDateParser.parse(bill.endDate),
      month: _parseMonth(bill.month),
      isInstallment: bill.isInstallment == 1,
      studentName: student.name,
      studentNis: student.nis,
      studentClass: student.className ?? '',
      installmentsConfirmed:
          (billInstallmentConfirmed ?? []).map((e) => e.toEntity()).toList(),
      pendingInstallment: billInstallmentPendingOrPaid?.toEntity(),
      latestTransactionRedirectUrl: latestTransactions?.redirectUrl,
      latestTransactionVirtualAccount: latestTransactions?.virtualAccount,
      latestTransactionTrxId: latestTransactions?.trxId,
      latestTransactionStatus: latestTransactions?.status,
      latestTransactionAmount: latestTransactions?.amount,
    );
  }
}

extension BillInstallmentMapper on BillInstallmentModel {
  BillInstallmentEntity toEntity() {
    return BillInstallmentEntity(
      id: id,
      payDate: SafeDateParser.parse(payDate),
      payAmount: payAmount,
      payMethod: payMethod,
      status: _mapStatus(status),
    );
  }
}

extension PaymentMethodMapper on PaymentMethodModel {
  PaymentMethodEntity toEntity() {
    return PaymentMethodEntity(id: id, name: name, slug: slug);
  }
}

extension NoRekeningMapper on NoRekeningModel {
  BankTransferInfoEntity toEntity() {
    return BankTransferInfoEntity(
      bankLogo: bankLogo,
      bankAccount: bankAccount,
      bankName: bankName,
      bankNumber: bankNumber,
      adminFeeSpp: adminFeeSpp,
      adminFeeDpp: adminFeeDpp,
      adminFeeLainnya: adminFeeLainnya,
      adminFeeEmoney: adminFeeEmoney,
    );
  }
}

BillCategoryType _mapCategory(String type) {
  final lower = type.toLowerCase();
  return BillCategoryType.values.firstWhere(
    (e) => e.name == lower,
    orElse: () => BillCategoryType.lainnya,
  );
}

BillStatusType _mapStatus(String status) {
  final lower = status.toLowerCase();
  return BillStatusType.values.firstWhere(
    (e) => e.name == lower,
    orElse: () => BillStatusType.unpaid,
  );
}

DateTime? _parseMonth(String? month) {
  if (month == null || month.startsWith('0000')) return null;
  return SafeDateParser.parse(month);
}
