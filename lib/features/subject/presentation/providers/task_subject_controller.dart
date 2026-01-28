import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/shared/core/domain/entities/task_entity.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:gaia/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_subject_controller.g.dart';

@riverpod
class TaskSubjectController extends _$TaskSubjectController {
  Timer? _ttl; // for optional TTL keepAlive
  KeepAliveLink? _link;

  int page = 1;
  static const _pageSize = 10;
  bool _loadingMore = false;

  @override
  AsyncValue<Paged<TaskEntity>> build(int idSubject) {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());
    _firstLoad(idSubject); // kick first page
    return const AsyncLoading(); // so UI can use `.when(loading: ...)`
  }

  Future<List<TaskEntity>> _fetch(int idSubject, int page) async {
    final uc = ref.read(getListSubjectTaskUsecaseProvider);
    final either = await uc.getTasks(idSubject, page: page);
    return either.fold((e) => throw e, (list) => list);
  }

  Future<void> _firstLoad(int idSubject) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await _fetch(idSubject, 1);
      return Paged(
        items: items,
        page: 1,
        hasMore: items.length >= _pageSize,
      );
    });
  }

  Future<void> refresh(int idSubject) async => _firstLoad(idSubject);

  Future<void> loadMore(int idSubject) async {
    final data = state.asData?.value;
    if (data == null || _loadingMore || !data.hasMore) return;

    _loadingMore = true;
    state = AsyncValue.data(data.copyWith(isMoreLoading: true, error: null));
    try {
      final next = data.page + 1;
      final items = await _fetch(idSubject, next);
      final updated = data.copyWith(
        items: [...data.items, ...items],
        page: next,
        hasMore: items.length >= _pageSize,
        isMoreLoading: false,
      );
      state = AsyncValue.data(updated);
    } catch (e, st) {
      // keep previous list, surface error on state
      state =
          AsyncValue<Paged<TaskEntity>>.error(e, st).copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}
