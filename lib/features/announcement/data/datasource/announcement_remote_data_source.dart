import 'package:dio/dio.dart';
import 'package:gaia/features/announcement/data/models/announcement_model.dart';

class AnnouncementRemoteDataSource {
  final Dio _dio;
  AnnouncementRemoteDataSource(this._dio);

  Future<List<AnnouncementModel>> getListAnnouncement() async {
    final res = await _dio.get('/announcement/list');
    final data = (res.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map(
          (e) => AnnouncementModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<AnnouncementModel> getDetailAnnouncement(int id) async {
    final res = await _dio.get('/announcement/get-detail',
        queryParameters: {'announcement_id': id});
    final data = AnnouncementModel.fromJson(res.data['data']);
    return data;
  }
}
