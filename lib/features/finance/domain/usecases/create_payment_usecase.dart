import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class CreatePaymentUsecase {
  final BillRepository _repository;
  CreatePaymentUsecase(this._repository);

  Future<Result<Map<String, dynamic>>> call(
          String slug, Map<String, dynamic> body) =>
      _repository.createPayment(slug, body);
}
