
import 'package:icarus/features/chat/domain/chat_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class SendMessageUsecase {
  final ChatRepository _repository;
  SendMessageUsecase(this._repository);

  Future<Result<void>> sendMessage({
    required int userId,
    required String message,
  }) => _repository.sendMessage(userId, message);
}
