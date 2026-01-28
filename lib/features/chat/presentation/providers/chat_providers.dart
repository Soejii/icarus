
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/chat/data/chat_repository_impl.dart';
import 'package:gaia/features/chat/data/datasource/chat_remote_data_source.dart';
import 'package:gaia/features/chat/domain/chat_repository.dart';
import 'package:gaia/features/chat/domain/usecase/get_list_chat_usecase.dart';
import 'package:gaia/features/chat/domain/usecase/get_messages_chat_usecase.dart';
import 'package:gaia/features/chat/domain/usecase/get_contacts_usecase.dart';
import 'package:gaia/features/chat/domain/usecase/send_message_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_providers.g.dart';

@riverpod
ChatRemoteDataSource chatRemoteDataSource(Ref ref) {
  return ChatRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepositoryImpl(
    ref.watch(chatRemoteDataSourceProvider),
  );
}

@riverpod
GetListChatUsecase getListChatUsecase(Ref ref) {
  return GetListChatUsecase(
    ref.watch(chatRepositoryProvider),
  );
}

@riverpod
GetMessagesUsecase getMessagesUsecase(Ref ref) {
  return GetMessagesUsecase(
    ref.watch(chatRepositoryProvider),
  );
}

@riverpod
GetContactsUsecase getContactsUsecase(Ref ref) {
  return GetContactsUsecase(
    ref.watch(chatRepositoryProvider),
  );
}

@riverpod
SendMessageUsecase sendMessageUsecase(Ref ref) {
  return SendMessageUsecase(
    ref.watch(chatRepositoryProvider),
  );
}