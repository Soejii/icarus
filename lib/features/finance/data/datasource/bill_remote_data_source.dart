import 'package:dio/dio.dart';
import 'package:icarus/features/finance/data/models/bill_detail_model.dart';
import 'package:icarus/features/finance/data/models/bill_transaction_model.dart';
import 'package:icarus/features/finance/data/models/home_bill_model.dart';
import 'package:icarus/features/finance/data/models/no_rekening_model.dart';
import 'package:icarus/features/finance/data/models/payment_method_model.dart';

class BillRemoteDataSource {
  final Dio _dio;
  BillRemoteDataSource(this._dio);

  Future<HomeBillModel> getHomeBill(int studentId) async {
    final res = await _dio.get('/bill/home-bill/$studentId');
    return HomeBillModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<List<BillTransactionModel>> getListUnpaid(
      int studentId, String type) async {
    final res = await _dio.get(
      '/bill/list-unpaid/$studentId',
      queryParameters: {'type': type},
    );
    final data = (res.data['data'] as List<dynamic>? ?? []);
    return data
        .map((e) => BillTransactionModel.fromJson(
            Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<List<BillTransactionModel>> getListPaid(
    int studentId,
    String type, {
    int limit = 10,
    int offset = 0,
  }) async {
    final res = await _dio.get(
      '/bill/list-paid/$studentId',
      queryParameters: {'type': type, 'limit': limit, 'offset': offset},
    );
    final data = (res.data['data'] as List<dynamic>? ?? []);
    return data
        .map((e) => BillTransactionModel.fromJson(
            Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<List<BillTransactionModel>> getListAllBills(int studentId) async {
    final res = await _dio.get('/bill/list-all-bill/$studentId');
    final data = (res.data['data'] as List<dynamic>? ?? []);
    return data
        .map((e) => BillTransactionModel.fromJson(
            Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<BillDetailModel> getBillDetail(int billTrxId) async {
    final res = await _dio.get(
      '/bill/get-detail',
      queryParameters: {'bill_trx_id': billTrxId},
    );
    return BillDetailModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final res = await _dio.get('/bill/payment-methods');
    final data = (res.data['data'] as List<dynamic>? ?? []);
    return data
        .map((e) =>
            PaymentMethodModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<NoRekeningModel> getNoRekening(int studentId) async {
    final res = await _dio.get('/bill/no-rekening/$studentId');
    return NoRekeningModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<Map<String, dynamic>> createPayment(
      String slug, Map<String, dynamic> body) async {
    final res = await _dio.post('/bill/create-payment/$slug', data: body);
    return Map<String, dynamic>.from(res.data['data'] as Map? ?? {});
  }

  Future<void> submitTransfer(FormData data) async {
    await _dio.post('/bill/submit-transfer', data: data);
  }

  Future<void> transferConfirmation(FormData data) async {
    await _dio.post('/bill/transfer-confirmation', data: data);
  }

  Future<void> cancelTransfer(FormData data) async {
    await _dio.post('/bill/cancel-transfer', data: data);
  }

  Future<Map<String, dynamic>> payMultiple(Map<String, dynamic> body) async {
    final res = await _dio.post('/bill/pay-multiple', data: body);
    return Map<String, dynamic>.from(res.data['data'] as Map? ?? {});
  }

  Future<void> payWithEmoney(FormData data) async {
    await _dio.post('/bill/pay-with-emoney', data: data);
  }

  Future<String> downloadInvoice(int billTrxId) async {
    final res = await _dio.get(
      '/bill/download-invoice',
      queryParameters: {'bill_trx_id': billTrxId},
    );
    return res.data['data']?.toString() ?? '';
  }
}
