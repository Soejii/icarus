import 'package:dio/dio.dart';
import 'package:gaia/features/schedule/data/models/schedule_model.dart';

class ScheduleRemoteDataSource {
  final Dio _dio;
  ScheduleRemoteDataSource(this._dio);

  Future<List<ScheduleModel>> getScheduleByDay(String day) async {
    final res = await _dio.get(
      '/subject-schedule',
      queryParameters: {'day': day},
    );
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => ScheduleModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }
}
