import 'package:icarus/features/notifications/domain/entities/notification_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class NotificationRepository {
  Future<Result<List<NotificationEntity>>> getListNotification(int page);
  Future<Result> readNotification(int notificationId);
}
