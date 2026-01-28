import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/activity/presentation/providers/activity_providers.dart';
import 'package:gaia/features/notifications/domain/entities/notification_entity.dart';
import 'package:gaia/features/notifications/domain/type/notification_type.dart';
import 'package:gaia/features/notifications/domain/type/notification_type_extension.dart';
import 'package:gaia/features/notifications/presentation/providers/notification_controller.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class NotificationCard extends ConsumerWidget {
  const NotificationCard({super.key, required this.entity});
  final NotificationEntity entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    handleRoutes() {
      switch (entity.type) {
        case NotificationType.newMark:
        case NotificationType.newMarkCBT:
          context.pop();
          ref.read(activityTabIndexProvider.notifier).set(0);
          context.goNamed(RouteName.activity);
          break;

        case NotificationType.newAnnouncement:
        case NotificationType.announcement:
          context.pushNamed(
            RouteName.detailAnnouncement,
            pathParameters: {'id': entity.dataId.toString()},
          );
          break;

        case NotificationType.newModule:
        case NotificationType.newSubModule:
          ref.read(detailSubjectTabIndexProvider.notifier).set(0);
          context.pushNamed(
            RouteName.detailSubject,
            pathParameters: {'id': entity.dataId.toString()},
          );
          break;
        default:
      }
    }

    return GestureDetector(
      onTap: () {
        ref
            .read(notificationControllerProvider.notifier)
            .readNotification(entity.id);
        handleRoutes();
      },
      child: Container(
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
          ),
          color: entity.isRead
              ? const Color.fromRGBO(255, 255, 255, 1)
              : const Color.fromRGBO(221, 243, 255, 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.h,
                width: 60.h,
                child: Image.asset(
                  entity.type.getIcon,
                ),
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      entity.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: context.brand.textMain,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      entity.desc ?? '-',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textMain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
