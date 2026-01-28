
import 'package:gaia/features/chat/domain/chat_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class SendMessageUsecase {
  final ChatRepository _repository;
  SendMessageUsecase(this._repository);

  Future<Result<void>> sendMessage({
    required int userId,
    required String message,
  }) => _repository.sendMessage(userId, message);
}
