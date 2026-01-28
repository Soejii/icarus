import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/chat/domain/entity/chat_message_entity.dart';
import 'package:icarus/features/chat/domain/entity/chat_entity.dart';
import 'package:icarus/features/chat/domain/type/chat_message_type.dart';
import 'package:icarus/features/chat/presentation/providers/chat_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_detail_controller.g.dart';

@riverpod
Future<ChatEntity> chatDetailEntity(ChatDetailEntityRef ref, int userId) async {
  final uc = ref.read(getMessagesUsecaseProvider);
  final either = await uc.getMessages(userId: userId, page: 1);

  return either.fold(
    (failure) => throw failure,
    (response) => response,
  );
}

@riverpod
class ChatDetailController extends _$ChatDetailController {
  Timer? _ttl;
  Timer? _autoRefreshTimer;
  KeepAliveLink? _link;

  static const _pageSize = 15;
  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  @override
  AsyncValue<Paged<ChatMessageEntity>> build(int userId) {
    _link ??= ref.keepAlive();

    ref.onCancel(() {
      _stopAutoRefresh();
      _ttl = Timer(const Duration(minutes: 3), () {
        _link?.close();
        _link = null;
      });
    });

    ref.onResume(() {
      _ttl?.cancel();
      _startAutoRefresh();
    });

    ref.onDispose(() {
      _ttl?.cancel();
      _autoRefreshTimer?.cancel();
    });

    _startAutoRefresh();
    _loadInitial();
    return const AsyncLoading();
  }

  Future<List<ChatMessageEntity>> _fetchMessages(int page) async {
    final uc = ref.read(getMessagesUsecaseProvider);
    final either = await uc.getMessages(userId: userId, page: page);

    return either.fold(
      (failure) => throw failure,
      (response) => response.messages ?? [],
    );
  }

  Future<void> _loadInitial() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await _fetchMessages(1);
      return Paged(
        items: items,
        page: 1,
        hasMore: items.length >= _pageSize,
      );
    });
  }

  Future<void> refresh() async => _loadInitial();
  Future<void> loadMore() async {
    final data = state.value;
    if (data == null || _isLoadingMore || !data.hasMore) return;

    _isLoadingMore = true;

    try {
      final nextPage = data.page + 1;
      final olderMessages = await _fetchMessages(nextPage);

      final updated = data.copyWith(
        items: [...olderMessages, ...data.items],
        page: nextPage,
        hasMore: olderMessages.length >= _pageSize,
      );

      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue<Paged<ChatMessageEntity>>.error(e, st);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (state.hasValue && !_isLoadingMore) _checkNewMessages();
    });
  }

  void _stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = null;
  }

  void startAutoRefresh() => _startAutoRefresh();
  void stopAutoRefresh() => _stopAutoRefresh();

  Future<void> _checkNewMessages() async {
    try {
      final currentData = state.value;
      if (currentData == null || currentData.items.isEmpty) return;

      final latestMessages = await _fetchMessages(1);
      if (latestMessages.isEmpty) return;

      final lastCurrentTime = currentData.items.last.createdAt;
      final newMessages = latestMessages.where((msg) {
        final isNewer = msg.createdAt.compareTo(lastCurrentTime) > 0;
        final notExists = !currentData.items.any((existing) => 
          existing.message == msg.message && existing.type == msg.type
        );
        return isNewer && notExists;
      }).toList();

      if (newMessages.isNotEmpty) {
        final filteredItems = currentData.items.where((existing) {
          if (existing.type != ChatMessageType.send) return true;

          return !newMessages.any((newMsg) => 
            newMsg.message == existing.message && 
            newMsg.type == ChatMessageType.send
          );
        }).toList();

        final updated = currentData.copyWith(
          items: [...filteredItems, ...newMessages],
        );
        state = AsyncData(updated);
      }
    } catch (_) {}
  }

  void addOptimisticMessage(String message) {
    final data = state.value;
    if (data == null) return;

    final optimisticMessage = ChatMessageEntity(
      type: ChatMessageType.send,
      message: message,
      createdAt: DateTime.now().toIso8601String().replaceFirst('T', ' ').substring(0, 19),
    );

    state = AsyncData(data.copyWith(
      items: [...data.items, optimisticMessage],
    ));
  }

  void removeOptimisticMessage(String message) {
    final data = state.value;
    if (data == null) return;

    final updatedItems = data.items
        .where((msg) => !(msg.message == message && msg.type == ChatMessageType.send))
        .toList();

    state = AsyncData(data.copyWith(items: updatedItems));
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    
    _stopAutoRefresh();

    try {
      final usecase = ref.read(sendMessageUsecaseProvider);
      final result = await usecase.sendMessage(userId: userId, message: message);

      result.fold(
        (failure) => throw failure,
        (_) => Future.delayed(const Duration(milliseconds: 200), _checkNewMessages),
      );
    } finally {
      Future.delayed(const Duration(milliseconds: 300), _startAutoRefresh);
    }
  }
}
