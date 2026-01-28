import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:icarus/features/chat/domain/entity/chat_entity.dart';
import 'package:icarus/features/chat/presentation/providers/chat_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  Timer? _refreshTimer;
  KeepAliveLink? _link;
  int page = 1;
  static const _pageSize = 10;
  bool _loadingMore = false;
  bool _isAutoRefreshEnabled = false;

  @override
  AsyncValue<Paged<ChatEntity>> build() {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _refreshTimer?.cancel();
      _isAutoRefreshEnabled = false;
      Timer(const Duration(minutes: 3), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() {
      startAutoRefresh();
    });
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });
    _firstLoad();
    startAutoRefresh();
    return const AsyncLoading();
  }

  Future<List<ChatEntity>> _fetch(int page) async {
    final uc = ref.read(getListChatUsecaseProvider);
    final either = await uc.getListChats(page);
    return either.fold((e) => throw e, (list) => list);
  }

  Future<void> _firstLoad() async {
    page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await _fetch(1);
      return Paged(
        items: items,
        page: 1,
        hasMore: items.length >= _pageSize,
      );
    });
  }

  Future<void> refresh() async => _firstLoad();

  Future<void> loadMore() async {
    final data = state.asData?.value;
    if (data == null || _loadingMore || !data.hasMore) return;

    _loadingMore = true;
    state = AsyncValue.data(data.copyWith(isMoreLoading: true, error: null));
    try {
      final next = data.page + 1;
      final items = await _fetch(next);
      final updated = data.copyWith(
        items: [...data.items, ...items],
        page: next,
        hasMore: items.length >= _pageSize,
        isMoreLoading: false,
      );
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue<Paged<ChatEntity>>.error(e, st).copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }

  void startAutoRefresh() {
    if (_isAutoRefreshEnabled) return;
    _isAutoRefreshEnabled = true;
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_isAutoRefreshEnabled && state.hasValue) {
        _silentRefresh();
      }
    });
  }

  void stopAutoRefresh() {
    _isAutoRefreshEnabled = false;
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  Future<void> _silentRefresh() async {
    try {
      final items = await _fetch(1);
      final data = state.asData?.value;
      if (data != null) {
        final updated = data.copyWith(
          items: items,
          page: 1,
          hasMore: items.length >= _pageSize,
        );
        state = AsyncValue.data(updated);
        page = 1;
      }
    } catch (_) {
      // Silent error handling
    }
  }
}
