import 'package:dio/dio.dart';
import 'package:gaia/features/balances/data/models/emoney_model.dart';
import 'package:gaia/features/balances/data/models/emoney_history_model.dart';
import 'package:gaia/features/balances/data/models/savings_model.dart';
import 'package:gaia/features/balances/data/models/savings_history_model.dart';

class BalanceRemoteDataSource {
  final Dio _dio;
  BalanceRemoteDataSource(this._dio);

  Future<EmoneyModel> getEmoneyBalance() async {
    final res = await _dio.get('/bill/detail-emoney');
    final data = EmoneyModel.fromJson(res.data['data']);
    return data;
  }

  Future<List<EmoneyHistoryModel>> getEmoneyHistory({int? page}) async {
    final offset = page != null ? (page - 1) * 10 : 0;
    final res = await _dio.get(
      '/bill/history-emoney',
      queryParameters: {
        'limit': 10,
        'offset': offset,
      },
    );
    final List<dynamic> emoneyData = res.data['data']['emoney'];
    return emoneyData.map((json) => EmoneyHistoryModel.fromJson(json)).toList();
  }

  Future<SavingsModel> getSavingsBalance() async {
    final res = await _dio.get('/topup/get-detail-topup-student');
    final data = SavingsModel.fromJson(res.data['data']);
    return data;
  }

  Future<List<SavingsHistoryModel>> getSavingsHistory({int? page}) async {
    final offset = page != null ? (page - 1) * 10 : 0;
    final res = await _dio.get(
      '/topup/get-detail-byStudentId',
      queryParameters: {
        'limit': 10,
        'offset': offset,
      },
    );
    final List<dynamic> savingsData = res.data['data'];
    return savingsData
        .map((json) => SavingsHistoryModel.fromJson(json))
        .toList();
  }
}
