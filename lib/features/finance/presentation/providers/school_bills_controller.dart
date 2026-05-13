import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_bills_controller.g.dart';

@Riverpod(keepAlive: true)
class SchoolBillsController extends _$SchoolBillsController {
  @override
  Future<List<BillTransactionEntity>> build(BillCategoryType category) async {
    final child = ref.watch(selectedChildProvider);
    if (child == null) return [];
    final usecase = ref.watch(getListUnpaidUsecaseProvider);
    final res = await usecase.call(child.id, category);
    return res.fold((f) => throw f, (e) => e);
  }

  Future<void> refresh() =>
      ref.refresh(schoolBillsControllerProvider(category).future);
}
