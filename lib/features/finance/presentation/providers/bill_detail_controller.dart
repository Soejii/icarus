import 'package:icarus/features/finance/domain/entities/bill_detail_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bill_detail_controller.g.dart';

@riverpod
class BillDetailController extends _$BillDetailController {
  @override
  Future<BillDetailEntity> build(int billTrxId) async {
    final usecase = ref.watch(getBillDetailUsecaseProvider);
    final res = await usecase.call(billTrxId);
    return res.fold((f) => throw f, (e) => e);
  }

  Future<void> refresh() =>
      ref.refresh(billDetailControllerProvider(billTrxId).future);
}
