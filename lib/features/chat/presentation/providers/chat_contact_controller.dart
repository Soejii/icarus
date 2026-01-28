import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/chat/domain/entity/chat_contact_entity.dart';
import 'package:icarus/features/chat/presentation/providers/chat_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_contact_controller.g.dart';

@riverpod
class ChatContactController extends _$ChatContactController {
  Timer? _ttl;
  KeepAliveLink? _link;

  int page = 1;
  static const _pageSize = 10;
  bool _loadingMore = false;

  @override
  AsyncValue<Paged<ChatContactEntity>> build(String roleName) {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());
    
    _firstLoad(roleName);
    return const AsyncLoading();
  }

  Future<void> _firstLoad(String roleName) async {
    page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await _fetch(roleName, 1);
      return Paged(
        items: items,
        page: 1,
        hasMore: items.length >= _pageSize,
      );
    });
  }

  Future<List<ChatContactEntity>> _fetch(String roleName, int page) async {
    final uc = ref.read(getContactsUsecaseProvider);
    final either = await uc.getContacts(role: roleName, page: page);
    return either.fold(
      (e) => throw e,
      (chatEntities) => chatEntities.map((chat) => chat.contact).toList(),
    );
  }

  Future<void> refresh(String roleName) async {
    page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await _fetch(roleName, 1);
      return Paged(
        items: items,
        page: 1,
        hasMore: items.length >= _pageSize,
      );
    });
  }

  Future<void> loadMore(String roleName) async {
    final data = state.asData?.value;
    if (data == null || _loadingMore || !data.hasMore) return;

    _loadingMore = true;
    state = AsyncValue.data(data.copyWith(isMoreLoading: true, error: null));
    try {
      final next = data.page + 1;
      final items = await _fetch(roleName, next);
      final updated = data.copyWith(
        items: [...data.items, ...items],
        page: next,
        hasMore: items.length >= _pageSize,
        isMoreLoading: false,
      );
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state =
          AsyncValue<Paged<ChatContactEntity>>.error(e, st).copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}