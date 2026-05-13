import 'package:icarus/features/finance/domain/entities/bill_detail_entity.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetBillDetailUsecase {
  final BillRepository _repository;
  GetBillDetailUsecase(this._repository);

  Future<Result<BillDetailEntity>> call(int billTrxId) =>
      _repository.getBillDetail(billTrxId);
}
