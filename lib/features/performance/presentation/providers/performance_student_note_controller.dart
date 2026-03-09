import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/presentation/providers/performance_providers.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'performance_student_note_controller.g.dart';

@riverpod
class PerformanceStudentNoteController extends _$PerformanceStudentNoteController {
  Timer? _ttl; // for optional TTL keepAlive
  KeepAliveLink? _link;

  int page = 1;
  static const _pageSize = 10;
  bool _loadingMore = false;

  @override
  AsyncValue<Paged<NoteEntity>> build() {
    _link ??= ref.keepAlive();
    ref.onCancel(() {
      _ttl = Timer(const Duration(minutes: 5), () {
        _link?.close();
        _link = null;
      });
    });
    ref.onResume(() => _ttl?.cancel());
    ref.onDispose(() => _ttl?.cancel());
    _firstLoad(); // kick first page
    return const AsyncLoading(); // so UI can use `.when(loading: ...)`
  }

  Future<List<NoteEntity>> _fetch(int page) async {
    final uc = ref.read(getListStudentNotesUsecaseProvider);
    final either = await uc.getListStudentNotes(
      idStudent: 385,
      page: page,
    );
    return either.fold((e) => throw e, (list) => list);
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
      // keep previous list, surface error on state
      state =
          AsyncValue<Paged<NoteEntity>>.error(e, st).copyWithPrevious(state);
    } finally {
      _loadingMore = false;
    }
  }
}
