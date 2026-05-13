import 'package:icarus/features/finance/domain/entities/home_bill_entity.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetHomeBillUsecase {
  final BillRepository _repository;
  GetHomeBillUsecase(this._repository);

  Future<Result<HomeBillEntity>> call(int studentId) =>
      _repository.getHomeBill(studentId);
}
