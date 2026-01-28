import 'package:icarus/features/chat/data/models/message_model.dart';
import 'package:icarus/features/chat/domain/entity/chat_message_entity.dart';
import 'package:icarus/features/chat/domain/type/chat_message_type.dart';

extension ChatMessageMapper on MessageModel {
  ChatMessageEntity toEntity() => ChatMessageEntity(
        type: ChatMessageType.fromString(type ?? 'receive'),
        message: message ?? '',
        createdAt: createdAt ?? '',
      );
}
