import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/providers/tahfidz_tahsin_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tahsin_controller.g.dart';

@riverpod
class TahsinController extends _$TahsinController {
  static const _pageSize = 10;
  int _page = 1;
  bool _loadingMore = false;
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  AsyncValue<Paged<TahsinRecord>> build() {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());

    final child = ref.watch(selectedChildProvider);
    if (child == null) {
      return const AsyncData(Paged(hasMore: false));
    }
    _firstLoad(child.id);
    return const AsyncLoading();
  }

  Future<List<TahsinRecord>> _fetch(int studentId, int page) async {
    final usecase = ref.read(getListTahsinUsecaseProvider);
    final result = await usecase.execute(studentId: studentId, page: page);
    return result.fold((failure) => throw failure, (list) => list);
  }

  Future<void> _firstLoad(int studentId) async {
    _page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await _fetch(studentId, 1);
      return Paged(
        items: items,
        page: 1,
        hasMore: items.length >= _pageSize,
        isFirstLoading: false,
      );
    });
  }

  Future<void> refresh() async {
    final child = ref.read(selectedChildProvider);
    if (child == null) return;
    await _firstLoad(child.id);
  }

  Future<void> loadMore() async {
    final data = state.asData?.value;
    final child = ref.read(selectedChildProvider);
    if (data == null || child == null || _loadingMore || !data.hasMore) return;

    _loadingMore = true;
    state = AsyncValue.data(data.copyWith(isMoreLoading: true, error: null));
    try {
      final next = _page + 1;
      final items = await _fetch(child.id, next);
      _page = next;
      state = AsyncValue.data(
        data.copyWith(
          items: [...data.items, ...items],
          page: next,
          hasMore: items.length >= _pageSize,
          isMoreLoading: false,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncValue<Paged<TahsinRecord>>.error(error, stackTrace)
          .copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}
