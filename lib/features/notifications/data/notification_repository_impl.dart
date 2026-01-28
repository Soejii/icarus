import 'package:gaia/features/notifications/data/datasource/notification_remote_data_source.dart';
import 'package:gaia/features/notifications/data/mappers/notification_mapper.dart';
import 'package:gaia/features/notifications/domain/entities/notification_entity.dart';
import 'package:gaia/features/notifications/domain/notification_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;
  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<NotificationEntity>>> getListNotification(int page) =>
      guard(() async {
        final models = await _remoteDataSource.getNotifications(page);
        return models.map((model) => model.toEntity()).toList();
      });

  @override
  Future<Result> readNotification(int notificationId) => guard(
        () async {
          final res = await _remoteDataSource.readNotification(notificationId);
          return res;
        },
      );
}
