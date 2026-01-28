import 'package:icarus/features/notifications/domain/notification_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class ReadNotificationUsecase {
  final NotificationRepository _repository;
  ReadNotificationUsecase(this._repository);

  Future<Result> readNotification(int notificationId) async {
    return await _repository.readNotification(notificationId);
  }
}
