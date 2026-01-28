import 'package:dio/dio.dart';
import 'package:gaia/features/attendance/data/models/attendance_model.dart';

class AttendanceRemoteDataSource {
  final Dio _dio;
  AttendanceRemoteDataSource(this._dio);

  Future<List<AttendanceModel>> getAttendanceHistory() async {
    final res = await _dio.get('/attendance/get-history');
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => AttendanceModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }
}
