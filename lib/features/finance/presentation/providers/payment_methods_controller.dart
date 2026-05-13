import 'package:icarus/features/finance/domain/entities/payment_method_entity.dart';
import 'package:icarus/features/finance/presentation/providers/finance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_methods_controller.g.dart';

@Riverpod(keepAlive: true)
class PaymentMethodsController extends _$PaymentMethodsController {
  @override
  Future<List<PaymentMethodEntity>> build() async {
    final usecase = ref.watch(getPaymentMethodsUsecaseProvider);
    final res = await usecase.call();
    return res.fold((f) => throw f, (e) => e);
  }
}
