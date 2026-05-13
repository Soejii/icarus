import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class PayWithEmoneyUsecase {
  final BillRepository _repository;
  PayWithEmoneyUsecase(this._repository);

  Future<Result<void>> call({
    required int studentId,
    required int billTrxId,
    required int amount,
    String? notes,
  }) =>
      _repository.payWithEmoney(
        studentId: studentId,
        billTrxId: billTrxId,
        amount: amount,
        notes: notes,
      );
}
