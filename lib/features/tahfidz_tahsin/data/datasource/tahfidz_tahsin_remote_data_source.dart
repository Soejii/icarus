import 'package:dio/dio.dart';
import 'package:icarus/features/tahfidz_tahsin/data/models/tahfidz_tahsin_model.dart';

class TahfidzTahsinRemoteDataSource {
  final Dio _dio;
  TahfidzTahsinRemoteDataSource(this._dio);

  Future<List<TahfidzModel>> getListTahfidz(int studentId, int page) async {
    final res = await _dio.get(
      '/tahfidz-tahsin/get-tahfidz/$studentId',
      queryParameters: {
        'paginate': true,
        'page': page,
        'limit': 5,
      },
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map((e) => TahfidzModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<List<TahsinModel>> getListTahsin(int studentId, int page) async {
    final res = await _dio.get(
      '/tahfidz-tahsin/get-tahsin/$studentId',
      queryParameters: {
        'paginate': true,
        'page': page,
        'limit': 5,
      },
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map((e) => TahsinModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }
}
