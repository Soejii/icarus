import 'package:dio/dio.dart';
import 'package:icarus/features/finance/data/datasource/bill_remote_data_source.dart';
import 'package:icarus/features/finance/data/mappers/bill_mapper.dart';
import 'package:icarus/features/finance/domain/entities/bank_transfer_info_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_detail_entity.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/entities/home_bill_entity.dart';
import 'package:icarus/features/finance/domain/entities/payment_method_entity.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class BillRepositoryImpl implements BillRepository {
  final BillRemoteDataSource _dataSource;
  BillRepositoryImpl(this._dataSource);

  @override
  Future<Result<HomeBillEntity>> getHomeBill(int studentId) => guard(
        () async {
          final model = await _dataSource.getHomeBill(studentId);
          return HomeBillEntity(
            studentName: model.student.name,
            studentNis: model.student.nis,
            studentClass: model.student.className,
            unpaidTotal: model.unpaidTotal,
            unpaidSpp: model.unpaidSpp,
            unpaidDpp: model.unpaidDpp,
            unpaidLainnya: model.unpaidLainnya,
            info: model.info,
          );
        },
      );

  @override
  Future<Result<List<BillTransactionEntity>>> getListUnpaid(
          int studentId, BillCategoryType type) =>
      guard(() async {
        final models =
            await _dataSource.getListUnpaid(studentId, type.name);
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Result<List<BillTransactionEntity>>> getListPaid(
          int studentId, BillCategoryType type,
          {int limit = 10, int offset = 0}) =>
      guard(() async {
        final models = await _dataSource.getListPaid(studentId, type.name,
            limit: limit, offset: offset);
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Result<List<BillTransactionEntity>>> getListAllBills(
          int studentId) =>
      guard(() async {
        final models = await _dataSource.getListAllBills(studentId);
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Result<BillDetailEntity>> getBillDetail(int billTrxId) =>
      guard(() async {
        final model = await _dataSource.getBillDetail(billTrxId);
        return model.toEntity();
      });

  @override
  Future<Result<List<PaymentMethodEntity>>> getPaymentMethods() =>
      guard(() async {
        final models = await _dataSource.getPaymentMethods();
        return models.map((m) => m.toEntity()).toList();
      });

  @override
  Future<Result<BankTransferInfoEntity>> getNoRekening(int studentId) =>
      guard(() async {
        final model = await _dataSource.getNoRekening(studentId);
        return model.toEntity();
      });

  @override
  Future<Result<Map<String, dynamic>>> createPayment(
          String slug, Map<String, dynamic> body) =>
      guard(() => _dataSource.createPayment(slug, body));

  @override
  Future<Result<void>> submitTransfer({
    required int billTrxId,
    required int amount,
    String? notes,
  }) =>
      guard(() async {
        final data = FormData.fromMap({
          'bill_trx_id': billTrxId.toString(),
          'amount': amount.toString(),
          if (notes != null) 'notes': notes,
        });
        await _dataSource.submitTransfer(data);
      });

  @override
  Future<Result<void>> transferConfirmation({
    required int billTrxId,
    required String filePath,
  }) =>
      guard(() async {
        final data = FormData.fromMap({
          'bill_trx_id': billTrxId.toString(),
          'evidence': await MultipartFile.fromFile(filePath),
        });
        await _dataSource.transferConfirmation(data);
      });

  @override
  Future<Result<void>> cancelTransfer(int transferId) =>
      guard(() async {
        final data = FormData.fromMap({
          'transfer_id': transferId.toString(),
        });
        await _dataSource.cancelTransfer(data);
      });

  @override
  Future<Result<Map<String, dynamic>>> payMultiple(
          String paymentMethod, int studentId, List<Map<String, dynamic>> bills) =>
      guard(() => _dataSource.payMultiple({
            'payment_method': paymentMethod,
            'student_id': studentId,
            'bills': bills,
          }));

  @override
  Future<Result<void>> payWithEmoney({
    required int studentId,
    required int billTrxId,
    required int amount,
    String? notes,
  }) =>
      guard(() async {
        final data = FormData.fromMap({
          'student_id': studentId.toString(),
          'bill_trx_id': billTrxId.toString(),
          'amount': amount.toString(),
          if (notes != null) 'notes': notes,
        });
        await _dataSource.payWithEmoney(data);
      });

  @override
  Future<Result<String>> downloadInvoice(int billTrxId) =>
      guard(() => _dataSource.downloadInvoice(billTrxId));
}
