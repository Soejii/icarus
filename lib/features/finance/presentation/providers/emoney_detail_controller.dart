import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/finance/domain/entities/emoney_detail_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoney_detail_controller.g.dart';

@Riverpod(keepAlive: true)
class EmoneyDetailController extends _$EmoneyDetailController {
  @override
  Future<EmoneyDetailEntity?> build() async {
    final child = ref.watch(selectedChildProvider);
    if (child == null) return null;
    final usecase = ref.watch(getEmoneyDetailUsecaseProvider);
    final res = await usecase.call(child.id);
    return res.fold((f) => throw f, (e) => e);
  }

  Future<void> refresh() =>
      ref.refresh(emoneyDetailControllerProvider.future);
}
