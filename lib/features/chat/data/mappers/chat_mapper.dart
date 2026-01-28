import 'package:icarus/features/chat/data/models/chat_model.dart';
import 'package:icarus/features/chat/data/mappers/chat_messages_mapper.dart';
import 'package:icarus/features/chat/domain/entity/chat_entity.dart';
import 'package:icarus/features/chat/domain/entity/chat_contact_entity.dart';

extension ChatMapper on ChatModel {
  ChatEntity toEntity() => ChatEntity(
        contact: ChatContactEntity(
          id: userId ?? user?.userId ?? 0,
          role: role ?? user?.role,
          className: className ?? user?.className,
          name: name ?? user?.name,
          photo: photo ?? user?.photo,
          lastChat: lastChat,
          lastChatDate: lastChatDate,
        ),
        messages: messages?.map((m) => m.toEntity()).toList(),
      );
}
