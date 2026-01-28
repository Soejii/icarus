import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/balances/domain/entities/emoney_history_entity.dart';
import 'package:gaia/features/balances/presentation/providers/balance_providers.dart';
import 'package:gaia/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoney_history_controller.g.dart';

@riverpod
class EmoneyHistoryController extends _$EmoneyHistoryController {
  Timer? _ttl;
  KeepAliveLink? _link;

  static const int _pageSize = 10;
  bool _loadingMore = false;

  @override
  AsyncValue<Paged<EmoneyHistoryEntity>> build() {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());
    _firstLoad();
    return const AsyncLoading();
  }

  Future<List<EmoneyHistoryEntity>> _fetch(int page) async {
    final usecase = ref.read(getEmoneyHistoryUsecaseProvider);
    final result = await usecase.getEmoneyHistory(page: page);
    return result.fold((e) => throw e, (list) => list);
  }

  Future<void> _firstLoad() async {
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
      state = AsyncValue<Paged<EmoneyHistoryEntity>>.error(e, st)
          .copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}
