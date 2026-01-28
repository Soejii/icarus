import 'package:gaia/features/chat/data/models/message_model.dart';
import 'package:gaia/features/chat/domain/entity/chat_message_entity.dart';
import 'package:gaia/features/chat/domain/type/chat_message_type.dart';

extension ChatMessageMapper on MessageModel {
  ChatMessageEntity toEntity() => ChatMessageEntity(
        type: ChatMessageType.fromString(type ?? 'receive'),
        message: message ?? '',
        createdAt: createdAt ?? '',
      );
}
