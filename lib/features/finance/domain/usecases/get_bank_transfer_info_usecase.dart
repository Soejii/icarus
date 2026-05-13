import 'package:icarus/features/finance/domain/entities/bank_transfer_info_entity.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetBankTransferInfoUsecase {
  final BillRepository _repository;
  GetBankTransferInfoUsecase(this._repository);

  Future<Result<BankTransferInfoEntity>> call(int studentId) =>
      _repository.getNoRekening(studentId);
}
