import 'package:dio/dio.dart';
import 'package:icarus/features/edutainment/data/models/digital_magazine_model.dart';
import 'package:icarus/features/edutainment/data/models/edutainment_model.dart';

class EdutainmentRemoteDataSource {
  final Dio _dio;
  EdutainmentRemoteDataSource(this._dio);

  Future<List<EdutainmentModel>> getListEdutainment(
      String? type, int page) async {
    final res = await _dio.get(
      '/magazines',
      queryParameters: {
        'type': type ?? 'all',
        'page': page,
      },
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map(
          (e) => EdutainmentModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<EdutainmentModel> getDetailEdutainment(int id) async {
    final res = await _dio.get('/magazines/$id');
    final data = EdutainmentModel.fromJson(res.data['data']);
    return data;
  }

  
  Future<List<DigitalMagazineModel>> getListDigitalMagazine() async {
    final res = await _dio.get(
      '/homepage/get-academic-calendar',
      // altough this shit is called academic calendar, IT IS a digital magazine. there's some hiccups with the upper up about it, and we just decide to fuck it
    );
    final data =
        (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => DigitalMagazineModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }
}
