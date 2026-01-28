import 'package:dio/dio.dart';
import 'package:icarus/features/school/data/models/school_model.dart';

class SchoolRemoteDataSource {
  final Dio _dio;
  SchoolRemoteDataSource(this._dio);

  Future<SchoolModel> getSchool() async {
    final res = await _dio.get('/school-profile');
    return SchoolModel.fromJson(res.data['data']);
  }
}
