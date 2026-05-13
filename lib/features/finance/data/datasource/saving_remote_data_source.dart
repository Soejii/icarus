import 'package:dio/dio.dart';
import 'package:icarus/features/finance/data/models/saving_detail_model.dart';
import 'package:icarus/features/finance/data/models/saving_transaction_model.dart';
import 'package:icarus/features/finance/data/models/spending_limit_model.dart';

class SavingRemoteDataSource {
  final Dio _dio;
  SavingRemoteDataSource(this._dio);

  Future<SavingDetailModel> getSavingDetail(int studentId) async {
    final res =
        await _dio.get('/topup/detail-topup-student/$studentId');
    return SavingDetailModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<List<SavingTransactionModel>> getSavingHistory(
    int studentId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final res = await _dio.get(
      '/topup/get-list/$studentId',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = (res.data['data']?['topup'] as List<dynamic>? ?? []);
    return data
        .map((e) => SavingTransactionModel.fromJson(
            Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<SavingTransactionModel> getSavingTransactionDetail(int id) async {
    final res = await _dio.get(
      '/topup/get-detail-byId',
      queryParameters: {'id': id},
    );
    return SavingTransactionModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<SpendingLimitModel> getSpendingLimit(int studentId) async {
    final res =
        await _dio.get('/transaction/get-limit/$studentId');
    return SpendingLimitModel.fromJson(
        Map<String, dynamic>.from(res.data['data'] as Map? ?? {}));
  }

  Future<void> setSpendingLimit(
      int studentId, Map<String, dynamic> body) async {
    await _dio.post('/transaction/set-limit/$studentId', data: body);
  }
}
