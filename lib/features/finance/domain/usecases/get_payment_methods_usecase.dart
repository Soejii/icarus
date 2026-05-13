import 'package:icarus/features/finance/domain/entities/payment_method_entity.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetPaymentMethodsUsecase {
  final BillRepository _repository;
  GetPaymentMethodsUsecase(this._repository);

  Future<Result<List<PaymentMethodEntity>>> call() =>
      _repository.getPaymentMethods();
}
