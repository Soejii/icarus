import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListPaidUsecase {
  final BillRepository _repository;
  GetListPaidUsecase(this._repository);

  Future<Result<List<BillTransactionEntity>>> call(
          int studentId, BillCategoryType type,
          {int limit = 20, int offset = 0}) =>
      _repository.getListPaid(studentId, type, limit: limit, offset: offset);
}
