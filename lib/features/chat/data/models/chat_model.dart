import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaia/features/chat/data/models/contact_model.dart';
import 'package:gaia/features/chat/data/models/message_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ChatModel({
    int? userId,
    String? photo,
    String? name,
    String? role,
    String? lastChat,
    String? lastChatDate,
    @JsonKey(name: 'class') String? className,
    ContactModel? user,
    List<MessageModel>? messages,
    bool? hasMore,
  }) = _ChatModel;
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
