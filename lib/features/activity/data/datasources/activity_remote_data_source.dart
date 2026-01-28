import 'package:dio/dio.dart';
import 'package:gaia/features/activity/data/models/exam_model.dart';

class ActivityRemoteDataSource {
  final Dio _dio;
  ActivityRemoteDataSource(this._dio);

  Future<List<ExamModel>> getExam(String type, int page) async {
    final res = await _dio.get(
      '/activity/get-all',
      queryParameters: {
        'exam_type': type,
        'page' : page,
        'perPage': 10,
      },
    );
    final data = (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map(
          (e) => ExamModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

}
