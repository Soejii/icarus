import 'package:icarus/features/finance/domain/entities/bank_transfer_info_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/entities/home_bill_entity.dart';
import 'package:icarus/features/finance/domain/entities/payment_method_entity.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class BillRepository {
  Future<Result<HomeBillEntity>> getHomeBill(int studentId);

  Future<Result<List<BillTransactionEntity>>> getListUnpaid(
      int studentId, BillCategoryType type);

  Future<Result<List<BillTransactionEntity>>> getListPaid(
      int studentId, BillCategoryType type,
      {int limit = 20, int offset = 0});

  Future<Result<List<BillTransactionEntity>>> getListAllBills(int studentId);

  Future<Result<BillDetailEntity>> getBillDetail(int billTrxId);

  Future<Result<List<PaymentMethodEntity>>> getPaymentMethods();

  Future<Result<BankTransferInfoEntity>> getNoRekening(int studentId);

  Future<Result<Map<String, dynamic>>> createPayment(
      String slug, Map<String, dynamic> body);

  Future<Result<Map<String, dynamic>>> submitTransfer({
    required int billTrxId,
    required int amount,
    String? notes,
  });

  Future<Result<void>> transferConfirmation({
    required int billTrxId,
    required String filePath,
  });

  Future<Result<void>> cancelTransfer(int transferId);

  Future<Result<Map<String, dynamic>>> payMultiple(
      String paymentMethod, int studentId, List<Map<String, dynamic>> bills);

  Future<Result<void>> payWithEmoney({
    required int studentId,
    required int billTrxId,
    required int amount,
    String? notes,
  });

  Future<Result<String>> downloadInvoice(int billTrxId);
}
