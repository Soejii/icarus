import 'package:icarus/features/finance/domain/entities/emoney_transaction_entity.dart';
import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetEmoneyHistoryUsecase {
  final EmoneyRepository _repository;
  GetEmoneyHistoryUsecase(this._repository);

  Future<Result<List<EmoneyTransactionEntity>>> call(int studentId,
          {int limit = 20, int offset = 0}) =>
      _repository.getEmoneyHistory(studentId, limit: limit, offset: offset);
}
