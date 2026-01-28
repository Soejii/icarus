import 'package:gaia/features/notifications/domain/type/notification_type.dart';

class NotificationEntity {
  final int id;
  final int dataId;
  final String? title;
  final String? desc;
  final bool isRead;
  final NotificationType type;
  final String? date;

  NotificationEntity({
    required this.id,
    required this.dataId,
    required this.title,
    required this.desc,
    required this.isRead,
    required this.type,
    required this.date,
  });
}
