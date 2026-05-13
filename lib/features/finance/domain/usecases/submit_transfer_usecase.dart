import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class SubmitTransferUsecase {
  final BillRepository _repository;
  SubmitTransferUsecase(this._repository);

  Future<Result<void>> call({
    required int billTrxId,
    required int amount,
    String? notes,
  }) =>
      _repository.submitTransfer(
          billTrxId: billTrxId, amount: amount, notes: notes);
}
