import 'package:gaia/features/chat/data/datasource/chat_remote_data_source.dart';
import 'package:gaia/features/chat/data/mappers/chat_mapper.dart';
import 'package:gaia/features/chat/domain/chat_repository.dart';
import 'package:gaia/features/chat/domain/entity/chat_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;
  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<ChatEntity>>> getListChats(int page) => guard(() async {
        final models = await _remoteDataSource.getListChats(page);
        return models.map((model) => model.toEntity()).toList();
      });

  @override
  Future<Result<ChatEntity>> getMessages(
    int userId,
    int page,
  ) => guard(() async {
        final response = await _remoteDataSource.getMessages(userId, page);
        return response.toEntity();
      });

  @override
  Future<Result<List<ChatEntity>>> getContacts(
    String role,
    int page,
  ) => guard(() async {
        final models = await _remoteDataSource.getContacts(role, page);
        return models.map((model) => model.toEntity()).toList();
      });

  @override
  Future<Result<void>> sendMessage(int userId, String message) => guard(() async {
        await _remoteDataSource.sendMessage(userId, message);
      });
}