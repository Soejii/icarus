import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gaia/features/chat/domain/entity/chat_entity.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:intl/intl.dart';

class ChatListItem extends ConsumerWidget {
  final ChatEntity chat;

  const ChatListItem({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = chat.contact;
    final hasPhoto = contact.photo?.isNotEmpty == true;

    return InkWell(
      onTap: () {
        context.pushNamed(
          RouteName.chatDetail,
          pathParameters: {'userId': contact.id.toString()},
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey[200],
              backgroundImage: hasPhoto ? NetworkImage(contact.photo!) : null,
              child: hasPhoto
                  ? null
                  : Icon(
                      Icons.person,
                      size: 24.r,
                      color: Colors.grey[600],
                    ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name ?? '-',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.textMain,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    contact.lastChat ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              _formatTime(contact.lastChatDate ?? ''),
              style: TextStyle(
                fontSize: 14.sp,
                color: context.brand.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String dateTime) {
    if (dateTime.isEmpty) return '';
    try {
      final DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('HH:mm').format(parsedDate);
    } catch (e) {
      return '';
    }
  }
}
