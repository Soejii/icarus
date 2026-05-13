import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saving_history_controller.g.dart';

@Riverpod(keepAlive: true)
class SavingHistoryController extends _$SavingHistoryController {
  static const _pageSize = 10;
  int _offset = 0;
  bool _hasMore = true;

  @override
  Future<List<SavingTransactionEntity>> build() async {
    final child = ref.watch(selectedChildProvider);
    if (child == null) return [];
    _offset = 0;
    _hasMore = true;
    final usecase = ref.watch(getSavingHistoryUsecaseProvider);
    final res = await usecase.call(child.id, limit: _pageSize, offset: 0);
    return res.fold((f) => throw f, (list) {
      _hasMore = list.length >= _pageSize;
      _offset = list.length;
      return list;
    });
  }

  bool get hasMore => _hasMore;

  Future<void> loadMore() async {
    if (!_hasMore) return;
    final child = ref.read(selectedChildProvider);
    if (child == null) return;
    final current = state.asData?.value ?? [];
    final usecase = ref.watch(getSavingHistoryUsecaseProvider);
    final res =
        await usecase.call(child.id, limit: _pageSize, offset: _offset);
    res.fold((f) => throw f, (more) {
      _hasMore = more.length >= _pageSize;
      _offset += more.length;
      state = AsyncData([...current, ...more]);
    });
  }

  Future<void> refresh() =>
      ref.refresh(savingHistoryControllerProvider.future);
}
