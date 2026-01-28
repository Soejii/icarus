import 'package:dio/dio.dart';
import 'package:gaia/features/notifications/data/models/notification_model.dart';

class NotificationRemoteDataSource {
  final Dio _dio;
  NotificationRemoteDataSource(this._dio);

  Future<List<NotificationModel>> getNotifications(int page) async {
    final res = await _dio.get('/notifications/get-all', queryParameters: {
      'per_page': 20,
      'page': page,
    });
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map(
          (e) => NotificationModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future readNotification(int notificationId) async {
    await _dio.post('/notifications/read/$notificationId');
  }
}
