enum ChatMessageType {
  send('send'),
  receive('receive');

  const ChatMessageType(this.value);
  final String value;

  static ChatMessageType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'send':
        return ChatMessageType.send;
      case 'receive':
        return ChatMessageType.receive;
      default:
        return ChatMessageType.receive;
    }
  }
}