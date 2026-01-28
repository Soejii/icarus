import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:intl/intl.dart';
import 'package:icarus/features/chat/domain/entity/chat_message_entity.dart';

class ChatMessageBubbleWidget extends StatelessWidget {
  final ChatMessageEntity message;

  const ChatMessageBubbleWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isReceived = message.isReceived;

    return Align(
      alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 8.h,
          left: isReceived ? 0 : 50.w,
          right: isReceived ? 50.w : 0,
        ),
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isReceived ? Colors.transparent : context.brand.primary,
              border: isReceived
                  ? Border.all(color: context.brand.primary, width: 1)
                  : null,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: isReceived
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.message,
                  style: TextStyle(
                    color: isReceived ? Colors.black : Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _formatTime(message.createdAt),
                    style: TextStyle(
                      color: isReceived ? Colors.grey[600] : Colors.white70,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return createdAt.split(' ').last.substring(0, 5);
    }
  }
}
