import 'package:dio/dio.dart';
import 'package:icarus/features/schedule/data/models/schedule_model.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';

class ScheduleRemoteDataSource {
  const ScheduleRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<ScheduleModel>> getScheduleByDay(DayOfWeek day, int studentId) async {
    final res = await _dio.get(
      '/schedule/get-by-day/$studentId',
      queryParameters: {'day': day.apiValue},
    );
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map((e) => ScheduleModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }
}
