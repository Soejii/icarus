import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/balances/domain/entities/savings_history_entity.dart';
import 'package:gaia/features/balances/presentation/providers/balance_providers.dart';
import 'package:gaia/shared/presentation/paged.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'savings_history_controller.g.dart';

@riverpod
class SavingsHistoryController extends _$SavingsHistoryController {
  Timer? _ttl;
  KeepAliveLink? _link;

  static const int _pageSize = 10;
  bool _loadingMore = false;

  @override
  AsyncValue<Paged<SavingsHistoryEntity>> build() {
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

  Future<List<SavingsHistoryEntity>> _fetch(int page) async {
    final usecase = ref.read(getSavingsHistoryUsecaseProvider);
    final result = await usecase.getSavingsHistory(page: page);
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

  Future<void> refresh() async {
    _loadingMore = false;
    await _firstLoad();
  }

  Future<void> loadMore() async {
    if (_loadingMore) return;
    
    final currentData = state.value;
    if (currentData == null || !currentData.hasMore) return;

    _loadingMore = true;
    final nextPage = currentData.page + 1;
    
    final newPagedData = currentData.copyWith(isMoreLoading: true);
    state = AsyncData(newPagedData);

    try {
      final newItems = await _fetch(nextPage);
      final updatedItems = [...currentData.items, ...newItems];
      
      state = AsyncData(Paged(
        items: updatedItems,
        page: nextPage,
        hasMore: newItems.length >= _pageSize,
      ));
    } catch (e) {
      state = AsyncData(currentData.copyWith(isMoreLoading: false));
    } finally {
      _loadingMore = false;
    }
  }
}
