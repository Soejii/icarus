import 'package:dio/dio.dart';
import 'package:icarus/features/pusat_unduh/data/models/pusat_unduh_model.dart';

class PusatUnduhRemoteDataSource {
  final Dio _dio;
  PusatUnduhRemoteDataSource(this._dio);

  Future<List<PusatUnduhModel>> getListPusatUnduh(int page) async {
    final res = await _dio.get(
      '/upload-center/get-materials',
      queryParameters: {'page': page},
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map((e) =>
            PusatUnduhModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }
}
