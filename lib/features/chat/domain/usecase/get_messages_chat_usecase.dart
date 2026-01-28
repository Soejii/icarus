import 'package:gaia/features/chat/domain/chat_repository.dart';
import 'package:gaia/features/chat/domain/entity/chat_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetMessagesUsecase {
  final ChatRepository _repository;
  GetMessagesUsecase(this._repository);

  Future<Result<ChatEntity>> getMessages({
    required int userId,
    required int page,
  }) =>
      _repository.getMessages(userId, page);
}