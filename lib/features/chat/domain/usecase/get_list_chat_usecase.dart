import 'package:icarus/features/chat/domain/chat_repository.dart';
import 'package:icarus/features/chat/domain/entity/chat_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListChatUsecase {
  final ChatRepository _repository;
  GetListChatUsecase(this._repository);

  Future<Result<List<ChatEntity>>> getListChats(int page) async {
    return await _repository.getListChats(page);
  }
}