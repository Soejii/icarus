import 'package:gaia/features/notifications/data/models/notification_model.dart';
import 'package:gaia/features/notifications/domain/entities/notification_entity.dart';
import 'package:gaia/features/notifications/domain/type/notification_type.dart';

extension NotificationMapper on NotificationModel {
  NotificationEntity toEntity() => NotificationEntity(
        id: id,
        dataId: dataId,
        title: title,
        desc: description,
        isRead: isRead == 1,
        type: _mapTypes(type),
        date: createdAt,
      );

  NotificationType _mapTypes(String? type) {
    switch (type?.toLowerCase()) {
      case 'newmodule':
        return NotificationType.newModule;
      case 'newmark':
        return NotificationType.newMark;
      case 'newsubnodule':
        return NotificationType.newSubModule;
      case 'newmarkcbt':
        return NotificationType.newMarkCBT;
      case 'newannouncement':
        return NotificationType.newAnnouncement;
      case 'announcement':
        return NotificationType.announcement;
      default:
        return NotificationType.unknown;
    }
  }
}
