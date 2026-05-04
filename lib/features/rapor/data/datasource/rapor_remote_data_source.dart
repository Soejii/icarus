import 'package:dio/dio.dart';
import 'package:icarus/features/rapor/data/models/rapor_history_page_model.dart';

class RaporRemoteDataSource {
  final Dio _dio;

  const RaporRemoteDataSource(this._dio);

  Future<RaporHistoryPageModel> getHistory({
    required int studentId,
    int page = 1,
    int limit = 20,
  }) async {
    final res = await _dio.get(
      '/study-report/$studentId',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );
    return RaporHistoryPageModel.fromJson(
      Map<String, dynamic>.from(res.data['data'] as Map),
    );
  }
}
