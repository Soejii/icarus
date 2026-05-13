import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/features/finance/domain/types/bill_category_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListUnpaidUsecase {
  final BillRepository _repository;
  GetListUnpaidUsecase(this._repository);

  Future<Result<List<BillTransactionEntity>>> call(
          int studentId, BillCategoryType type) =>
      _repository.getListUnpaid(studentId, type);
}
