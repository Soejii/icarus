import 'package:dio/dio.dart';
import 'package:icarus/features/child/data/models/child_model.dart';

class ChildRemoteDataSource {
  const ChildRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<ChildModel>> getChildren() async {
    final res = await _dio.get('/list-my-child');
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map((e) => ChildModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }
}
