import 'package:gaia/features/notifications/domain/entities/notification_entity.dart';
import 'package:gaia/features/notifications/domain/notification_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetNotificationUsecase {
  final NotificationRepository _repository;
  GetNotificationUsecase(this._repository);

  Future<Result<List<NotificationEntity>>> getListNotifications(
      int page) async {
    return await _repository.getListNotification(page);
  }
}
