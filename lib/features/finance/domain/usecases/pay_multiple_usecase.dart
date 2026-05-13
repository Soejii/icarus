import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class PayMultipleUsecase {
  final BillRepository _repository;
  PayMultipleUsecase(this._repository);

  Future<Result<Map<String, dynamic>>> call(
          String paymentMethod, int studentId, List<Map<String, dynamic>> bills) =>
      _repository.payMultiple(paymentMethod, studentId, bills);
}
