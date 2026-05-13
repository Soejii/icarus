import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/home_bill_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_bill_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeBillController extends _$HomeBillController {
  @override
  Future<HomeBillEntity?> build() async {
    final child = ref.watch(selectedChildProvider);
    if (child == null) return null;
    final usecase = ref.watch(getHomeBillUsecaseProvider);
    final res = await usecase.call(child.id);
    return res.fold((f) => throw f, (e) => e);
  }

  Future<void> refresh() => ref.refresh(homeBillControllerProvider.future);
}
