import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/chat/domain/entity/chat_message_entity.dart';
import 'package:gaia/features/chat/presentation/widgets/chat_message_bubble_widget.dart';
import 'package:gaia/features/chat/presentation/widgets/chat_date_separator_widget.dart';

class ChatMessageListWidget extends StatelessWidget {
  final List<ChatMessageEntity> messages;
  final ScrollController scrollController;

  const ChatMessageListWidget({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    // Sort messages: newest first (for reverse ListView)
    final sortedMessages = [...messages]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final groupedMessages = _groupMessagesByDate(sortedMessages);

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: EdgeInsets.all(16.w),
      itemCount: groupedMessages.length,
      physics: const ClampingScrollPhysics(), // Better scroll physics like WhatsApp
      cacheExtent: 1000, // Cache more items for smoother scrolling
      itemBuilder: (context, index) {
        final item = groupedMessages[index];
        if (item['type'] == 'date') {
          return ChatDateSeparatorWidget(date: item['date'] as String);
        } else {
          return ChatMessageBubbleWidget(message: item['message'] as ChatMessageEntity);
        }
      },
    );
  }

  List<Map<String, dynamic>> _groupMessagesByDate(
      List<ChatMessageEntity> messages) {
    final List<Map<String, dynamic>> grouped = [];
    String? lastDate;

    // For reverse ListView, we need to process in reverse order for proper date separators
    // This ensures date separators appear in correct chronological order
    final reversedMessages = messages.reversed.toList();
    
    for (final message in reversedMessages) {
      final messageDate = _extractDateFromString(message.createdAt);

      if (lastDate == null || lastDate != messageDate) {
        // Add date separator
        grouped.add({
          'type': 'date',
          'date': messageDate,
        });
        lastDate = messageDate;
      }

      grouped.add({
        'type': 'message',
        'message': message,
      });
    }

    // Reverse the grouped list to match ListView's reverse order
    return grouped.reversed.toList();
  }

  String _extractDateFromString(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeString.split(' ').first;
    }
  }
}
