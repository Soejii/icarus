import 'package:dio/dio.dart';
import 'package:icarus/features/sentra/data/models/sentra_model.dart';

class SentraRemoteDataSource {
  final Dio _dio;
  SentraRemoteDataSource(this._dio);

  Future<List<SentraModel>> getListSentra(int studentId, int page) async {
    final res = await _dio.get(
      '/sentra/get-sentra/$studentId',
      queryParameters: {'paginate': true, 'page': page},
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map((e) => SentraModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }
}
