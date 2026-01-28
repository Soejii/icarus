import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/chat/domain/entity/chat_contact_entity.dart';

class ChatContactListItem extends StatelessWidget {
  final ChatContactEntity contact;
  final VoidCallback? onTap;

  const ChatContactListItem({
    super.key,
    required this.contact,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = contact.photo?.isNotEmpty == true;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
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
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    contact.className ?? '-',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
