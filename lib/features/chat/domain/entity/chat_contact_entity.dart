class ChatContactEntity {
  final int id;
  final String? role;
  final String? className;
  final String? name;
  final String? photo;
  final String? lastChat;
  final String? lastChatDate;

  ChatContactEntity({
    required this.id,
    this.role,
    this.className,
    this.name,
    this.photo,
    this.lastChat,
    this.lastChatDate,
  });
}