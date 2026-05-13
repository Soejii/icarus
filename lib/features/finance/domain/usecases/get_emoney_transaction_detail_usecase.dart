import 'package:icarus/features/finance/domain/entities/emoney_transaction_entity.dart';
import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetEmoneyTransactionDetailUsecase {
  final EmoneyRepository _repository;
  GetEmoneyTransactionDetailUsecase(this._repository);

  Future<Result<EmoneyTransactionEntity>> call(int id) =>
      _repository.getEmoneyTransactionDetail(id);
}
