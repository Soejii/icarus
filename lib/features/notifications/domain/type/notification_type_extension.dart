import 'package:gaia/features/notifications/domain/type/notification_type.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';

extension NotificationTypeExtension on NotificationType {
  String get getIcon {
    switch (this) {
      case NotificationType.announcement:
      case NotificationType.newAnnouncement:
        return AssetsHelper.imgHomeButtonPengumuman;
      case NotificationType.newMark:
      case NotificationType.newMarkCBT:
        return AssetsHelper.imgQuiz;
      case NotificationType.newModule:
      case NotificationType.newSubModule:
        return AssetsHelper.imgSubjectPlaceholder;

      default:
        return AssetsHelper.imgSubjectPlaceholder;
    }
  }
}
