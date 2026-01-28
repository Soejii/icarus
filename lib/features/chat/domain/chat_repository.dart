import 'package:icarus/features/chat/domain/entity/chat_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class ChatRepository {
  Future<Result<List<ChatEntity>>> getListChats(int page);
  Future<Result<ChatEntity>> getMessages(
    int userId,
    int page,
  );
  Future<Result<List<ChatEntity>>> getContacts(
    String role,
    int page,
  );
  Future<Result<void>> sendMessage(int userId, String message);
}