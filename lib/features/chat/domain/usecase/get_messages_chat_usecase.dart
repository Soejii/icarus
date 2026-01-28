import 'package:icarus/features/chat/domain/chat_repository.dart';
import 'package:icarus/features/chat/domain/entity/chat_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetMessagesUsecase {
  final ChatRepository _repository;
  GetMessagesUsecase(this._repository);

  Future<Result<ChatEntity>> getMessages({
    required int userId,
    required int page,
  }) =>
      _repository.getMessages(userId, page);
}