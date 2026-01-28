import 'package:dio/dio.dart';
import 'package:gaia/features/chat/data/models/chat_model.dart';

class ChatRemoteDataSource {
  final Dio _dio;
  ChatRemoteDataSource(this._dio);

  Future<List<ChatModel>> getListChats(int page) async {
    final res = await _dio.get('/chat/get-list-chats', queryParameters: {
      'page': page,
      'perPage': 10,
    });

    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;

    return data
        .map(
          (e) => ChatModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<List<ChatModel>> getContacts(String role, int page) async {
    final res = await _dio.get('/chat/get-contacts', queryParameters: {
      'role': role,
      'page': page,
      'perPage': 10,
    });
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;

    return data
        .map(
          (e) => ChatModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<ChatModel> getMessages(
    int userId,
    int page,
  ) async {
    final res = await _dio.get('/chat/messages/$userId', queryParameters: {
      'page': page,
      'perPage': 20,
    });

    final responseData = res.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;

    final userData = data['user'] as Map<String, dynamic>;
    final chatsData = data['chats'] as Map<String, dynamic>;
    final messagesData = chatsData['data'] as List<dynamic>;

    final chatModelData = {
      'user': userData,
      'messages': messagesData,
    };

    return ChatModel.fromJson(chatModelData);
  }

  Future<void> sendMessage(int userId, String message) async {
    await _dio.post('/chat/send-message', data: {
      'user_id': userId,
      'message': message,
    });
  }
}
