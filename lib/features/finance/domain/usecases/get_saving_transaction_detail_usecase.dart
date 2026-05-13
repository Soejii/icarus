import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/domain/repositories/saving_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetSavingTransactionDetailUsecase {
  final SavingRepository _repository;
  GetSavingTransactionDetailUsecase(this._repository);

  Future<Result<SavingTransactionEntity>> call(int id) =>
      _repository.getSavingTransactionDetail(id);
}
