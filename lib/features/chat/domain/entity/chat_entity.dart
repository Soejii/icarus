import 'package:icarus/features/chat/domain/entity/chat_contact_entity.dart';
import 'package:icarus/features/chat/domain/entity/chat_message_entity.dart';

class ChatEntity {
  final ChatContactEntity contact;
  final List<ChatMessageEntity>? messages;

  ChatEntity({
    required this.contact,
    this.messages,
  });
}