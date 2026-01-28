import 'package:icarus/features/chat/domain/type/chat_message_type.dart';

class ChatMessageEntity {
  final ChatMessageType type;
  final String message;
  final String createdAt;

  const ChatMessageEntity({
    required this.type,
    required this.message,
    required this.createdAt,
  });

  bool get isReceived => type == ChatMessageType.receive;
  bool get isSent => type == ChatMessageType.send;
}
