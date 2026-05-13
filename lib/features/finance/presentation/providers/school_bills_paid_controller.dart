import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_bills_paid_controller.g.dart';

@Riverpod(keepAlive: true)
class SchoolBillsPaidController extends _$SchoolBillsPaidController {
  static const _pageSize = 20;
  int _offset = 0;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  @override
  Future<List<BillTransactionEntity>> build(BillCategoryType category) async {
    _offset = 0;
    _hasMore = true;
    final child = ref.watch(selectedChildProvider);
    if (child == null) return [];
    final usecase = ref.watch(getListPaidUsecaseProvider);
    final res = await usecase.call(
      child.id,
      category,
      limit: _pageSize,
      offset: _offset,
    );
    return res.fold((f) => throw f, (e) {
      _hasMore = e.length == _pageSize;
      return e;
    });
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    final child = ref.read(selectedChildProvider);
    if (child == null) return;
    final current = state.valueOrNull ?? [];
    _offset += _pageSize;
    final usecase = ref.read(getListPaidUsecaseProvider);
    final res = await usecase.call(
      child.id,
      category,
      limit: _pageSize,
      offset: _offset,
    );
    res.fold(
      (f) => _offset -= _pageSize,
      (newItems) {
        _hasMore = newItems.length == _pageSize;
        state = AsyncData([...current, ...newItems]);
      },
    );
  }
}
