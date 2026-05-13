import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/saving_detail_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saving_detail_controller.g.dart';

@Riverpod(keepAlive: true)
class SavingDetailController extends _$SavingDetailController {
  @override
  Future<SavingDetailEntity?> build() async {
    final child = ref.watch(selectedChildProvider);
    if (child == null) return null;
    final usecase = ref.watch(getSavingDetailUsecaseProvider);
    final res = await usecase.call(child.id);
    return res.fold((f) => throw f, (e) => e);
  }

  Future<void> refresh() =>
      ref.refresh(savingDetailControllerProvider.future);
}
