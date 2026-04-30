import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_providers.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'absence_letter_history_controller.g.dart';

@riverpod
class AbsenceLetterHistoryController extends _$AbsenceLetterHistoryController {
  int _page = 1;
  bool _loadingMore = false;
  Timer? _ttl;
  KeepAliveLink? _link;

  @override
  AsyncValue<Paged<AbsenceLetterEntity>> build() {
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
    final type = ref.watch(absenceLetterHistoryTypeProvider);
    if (child == null) {
      return const AsyncData(Paged(hasMore: false));
    }

    _firstLoad(child.id, type);
    return const AsyncLoading();
  }

  Future<Paged<AbsenceLetterEntity>> _fetch(
    int studentId,
    String type,
    int page,
  ) async {
    final usecase = ref.read(getAbsenceLetterHistoryUsecaseProvider);
    final result = await usecase.getHistory(
      studentId: studentId,
      type: type,
      page: page,
    );
    final historyPage = result.fold((failure) => throw failure, (data) => data);
    return Paged(
      items: historyPage.items,
      page: historyPage.currentPage,
      hasMore: historyPage.currentPage < historyPage.totalPages,
      isFirstLoading: false,
    );
  }

  Future<void> _firstLoad(int studentId, String type) async {
    _page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(studentId, type, 1));
  }

  Future<void> refresh() async {
    final child = ref.read(selectedChildProvider);
    final type = ref.read(absenceLetterHistoryTypeProvider);
    if (child == null) return;
    await _firstLoad(child.id, type);
  }

  Future<void> loadMore() async {
    final data = state.asData?.value;
    final child = ref.read(selectedChildProvider);
    final type = ref.read(absenceLetterHistoryTypeProvider);
    if (data == null || child == null || _loadingMore || !data.hasMore) return;

    _loadingMore = true;
    state = AsyncValue.data(data.copyWith(isMoreLoading: true, error: null));
    try {
      final next = _page + 1;
      final pageData = await _fetch(child.id, type, next);
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
      state = AsyncValue<Paged<AbsenceLetterEntity>>.error(e, st)
          .copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}
