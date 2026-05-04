import 'package:dio/dio.dart';
import 'package:icarus/features/rapor/data/models/rapor_period_model.dart';

class RaporRemoteDataSource {
  final Dio _dio;

  const RaporRemoteDataSource(this._dio);

  Future<List<RaporPeriodModel>> getHistory({
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
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>? ??
            const <dynamic>[];
    return data
        .map(
          (e) => RaporPeriodModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }
}
