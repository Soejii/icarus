import 'package:icarus/features/finance/domain/entities/saving_transaction_entity.dart';
import 'package:icarus/features/finance/domain/repositories/saving_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetSavingHistoryUsecase {
  final SavingRepository _repository;
  GetSavingHistoryUsecase(this._repository);

  Future<Result<List<SavingTransactionEntity>>> call(int studentId,
          {int limit = 10, int offset = 0}) =>
      _repository.getSavingHistory(studentId, limit: limit, offset: offset);
}
