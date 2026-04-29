import 'package:dio/dio.dart';
import 'package:icarus/features/konseling/data/models/konseling_detail_model.dart';
import 'package:icarus/features/konseling/data/models/konseling_list_model.dart';

class KonselingRemoteDataSource {
  final Dio _dio;
  KonselingRemoteDataSource(this._dio);

  Future<List<KonselingListModel>> getListKonseling(
      String type, int page) async {
    final res = await _dio.get(
      '/counseling/get-list/$type',
      queryParameters: {'page': page},
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map((e) =>
            KonselingListModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  Future<KonselingDetailModel> getDetailKonseling(
      String type, int id) async {
    final res = await _dio.get('/counseling/get-detail/$type/$id');
    return KonselingDetailModel.fromJson(
      res.data['data'] as Map<String, dynamic>,
    );
  }
}
