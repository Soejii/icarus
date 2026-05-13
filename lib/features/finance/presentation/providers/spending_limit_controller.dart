import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/spending_limit_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'spending_limit_controller.g.dart';

@Riverpod(keepAlive: true)
class SpendingLimitController extends _$SpendingLimitController {
  @override
  Future<SpendingLimitEntity?> build() async {
    final child = ref.watch(selectedChildProvider);
    if (child == null) return null;
    final usecase = ref.watch(getSpendingLimitUsecaseProvider);
    final res = await usecase.call(child.id);
    return res.fold((f) => throw f, (e) => e);
  }

  Future<void> setLimit(String type, int? amount) async {
    final child = ref.read(selectedChildProvider);
    if (child == null) return;
    final usecase = ref.read(setSpendingLimitUsecaseProvider);
    final res = await usecase.call(child.id, type, amount);
    res.fold((f) => throw f, (_) => ref.invalidateSelf());
  }
}
