import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/features/konseling/presentation/providers/konseling_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'konseling_controller.g.dart';

@riverpod
class KonselingTabIndex extends _$KonselingTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}

@riverpod
class KonselingController extends _$KonselingController {
  static const _pageSize = 10;
  int _page = 1;
  bool _loadingMore = false;
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  AsyncValue<Paged<KonselingEntity>> build(KonselingType type) {
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

  Future<List<KonselingEntity>> _fetch(int page) async {
    final uc = ref.read(getListKonselingUsecaseProvider);
    final result = await uc.getListKonseling(type: type, page: page);
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
      state = AsyncValue<Paged<KonselingEntity>>.error(e, st)
          .copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}

@riverpod
class DetailKonselingController extends _$DetailKonselingController {
  @override
  Future<KonselingEntity> build(KonselingType type, int id) async {
    final uc = ref.read(getDetailKonselingUsecaseProvider);
    final result = await uc.getDetailKonseling(type: type, id: id);
    return result.fold((f) => throw f, (entity) => entity);
  }
}
