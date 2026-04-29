import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/pusat_unduh/domain/entities/pusat_unduh_entity.dart';
import 'package:icarus/features/pusat_unduh/presentation/providers/pusat_unduh_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pusat_unduh_controller.g.dart';

@riverpod
class PusatUnduhController extends _$PusatUnduhController {
  static const _pageSize = 5;
  int _page = 1;
  bool _loadingMore = false;
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  AsyncValue<Paged<PusatUnduhEntity>> build() {
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

  Future<List<PusatUnduhEntity>> _fetch(int page) async {
    final uc = ref.read(getListPusatUnduhUsecaseProvider);
    final result = await uc.execute(page: page);
    return result.fold((f) => throw f, (list) => list);
  }

  Future<void> _firstLoad() async {
    _page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await _fetch(1);
      return Paged(
        items: items,
        page: 1,
        hasMore: items.length >= _pageSize,
        isFirstLoading: false,
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
      final next = _page + 1;
      final items = await _fetch(next);
      _page = next;
      state = AsyncValue.data(
        data.copyWith(
          items: [...data.items, ...items],
          page: next,
          hasMore: items.length >= _pageSize,
          isMoreLoading: false,
        ),
      );
    } catch (e, st) {
      state = AsyncValue<Paged<PusatUnduhEntity>>.error(e, st)
          .copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}
