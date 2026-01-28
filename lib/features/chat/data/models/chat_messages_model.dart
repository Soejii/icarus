import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/features/chat/data/models/contact_model.dart';
import 'package:icarus/features/chat/data/models/message_model.dart';

part 'chat_messages_model.freezed.dart';
part 'chat_messages_model.g.dart';

@freezed
class ChatMessagesModel with _$ChatMessagesModel {
  const factory ChatMessagesModel({
    required ContactModel user,
    required List<MessageModel> messages,
  }) = _ChatMessagesModel;

  factory ChatMessagesModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesModelFromJson(json);
}