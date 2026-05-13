import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/bank_transfer_info_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bank_transfer_info_controller.g.dart';

@Riverpod(keepAlive: true)
class BankTransferInfoController extends _$BankTransferInfoController {
  @override
  Future<BankTransferInfoEntity?> build() async {
    final child = ref.watch(selectedChildProvider);
    if (child == null) return null;
    final usecase = ref.watch(getBankTransferInfoUsecaseProvider);
    final res = await usecase.call(child.id);
    return res.fold((f) => throw f, (e) => e);
  }
}
