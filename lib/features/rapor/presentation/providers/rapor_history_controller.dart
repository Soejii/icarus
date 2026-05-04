import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_period_entity.dart';
import 'package:icarus/features/rapor/presentation/providers/rapor_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rapor_history_controller.g.dart';

@riverpod
class RaporHistoryController extends _$RaporHistoryController {
  int _page = 1;
  bool _loadingMore = false;
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  AsyncValue<Paged<RaporPeriodEntity>> build() {
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

  Future<Paged<RaporPeriodEntity>> _fetch(int studentId, int page) async {
    final usecase = ref.read(getRaporHistoryUsecaseProvider);
    final result = await usecase.getHistory(studentId: studentId, page: page);
    final pageData = result.fold((f) => throw f, (d) => d);
    return Paged(
      items: pageData.items,
      page: pageData.currentPage,
      hasMore: pageData.currentPage < pageData.totalPages,
      isFirstLoading: false,
    );
  }

  Future<void> _firstLoad(int studentId) async {
    _page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(studentId, 1));
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
      final pageData = await _fetch(child.id, next);
      _page = pageData.page;
      state = AsyncValue.data(
        data.copyWith(
          items: [...data.items, ...pageData.items],
          page: pageData.page,
          hasMore: pageData.hasMore,
          isMoreLoading: false,
        ),
      );
    } catch (e, st) {
      state = AsyncValue<Paged<RaporPeriodEntity>>.error(e, st)
          .copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}
