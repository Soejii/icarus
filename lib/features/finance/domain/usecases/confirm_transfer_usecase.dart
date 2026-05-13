import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class ConfirmTransferUsecase {
  final BillRepository _repository;
  ConfirmTransferUsecase(this._repository);

  Future<Result<void>> call({
    required int billTrxId,
    required String filePath,
  }) =>
      _repository.transferConfirmation(
          billTrxId: billTrxId, filePath: filePath);
}
