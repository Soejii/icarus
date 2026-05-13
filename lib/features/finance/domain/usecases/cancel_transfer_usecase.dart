import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class CancelTransferUsecase {
  final BillRepository _repository;
  CancelTransferUsecase(this._repository);

  Future<Result<void>> call(int transferId) =>
      _repository.cancelTransfer(transferId);
}
