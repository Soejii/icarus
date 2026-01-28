import 'package:icarus/features/chat/domain/chat_repository.dart';
import 'package:icarus/features/chat/domain/entity/chat_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetContactsUsecase {
  final ChatRepository _repository;
  GetContactsUsecase(this._repository);

  Future<Result<List<ChatEntity>>> getContacts({
    required String role,
    required int page,
  }) =>
      _repository.getContacts(role, page);
}