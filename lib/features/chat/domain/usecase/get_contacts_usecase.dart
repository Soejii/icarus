import 'package:gaia/features/chat/domain/chat_repository.dart';
import 'package:gaia/features/chat/domain/entity/chat_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetContactsUsecase {
  final ChatRepository _repository;
  GetContactsUsecase(this._repository);

  Future<Result<List<ChatEntity>>> getContacts({
    required String role,
    required int page,
  }) =>
      _repository.getContacts(role, page);
}