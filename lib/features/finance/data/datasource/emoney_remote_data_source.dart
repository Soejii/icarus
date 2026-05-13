import 'package:dio/dio.dart';
import 'package:icarus/features/finance/data/models/emoney_detail_model.dart';
import 'package:icarus/features/finance/data/models/emoney_transaction_model.dart';

class EmoneyRemoteDataSource {
  final Dio _dio;
  EmoneyRemoteDataSource(this._dio);

  Future<EmoneyDetailModel> getEmoneyDetail(int studentId) async {
    final res = await _dio.get('/bill/detail-emoney/$studentId');
    return EmoneyDetailModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<List<EmoneyTransactionModel>> getEmoneyHistory(
    int studentId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final res = await _dio.get(
      '/bill/history-emoney/$studentId',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = (res.data['data']?['emoney'] as List<dynamic>? ?? []);
    return data
        .map((e) => EmoneyTransactionModel.fromJson(
            Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<EmoneyTransactionModel> getEmoneyTransactionDetail(int id) async {
    final res = await _dio.get('/bill/detail-history-emoney/$id');
    return EmoneyTransactionModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<Map<String, dynamic>> topupTransfer(
      int studentId, FormData data) async {
    final res =
        await _dio.post('/bill/topup-transfer/$studentId', data: data);
    return Map<String, dynamic>.from(res.data['data'] as Map? ?? {});
  }

  Future<void> confirmTopup(FormData data) async {
    await _dio.post('/bill/emoney-topup-confirmation', data: data);
  }

  Future<void> editConfirmation(FormData data) async {
    await _dio.post('/bill/emoney-edit-confirmation', data: data);
  }

  Future<void> cancelTopup(FormData data) async {
    await _dio.post('/bill/emoney-cancel-topup', data: data);
  }
}
