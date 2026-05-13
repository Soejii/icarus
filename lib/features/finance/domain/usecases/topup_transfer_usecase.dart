import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class TopupTransferUsecase {
  final EmoneyRepository _repository;
  TopupTransferUsecase(this._repository);

  Future<Result<Map<String, dynamic>>> call({
    required int studentId,
    required int amount,
    String? notes,
  }) =>
      _repository.topupTransfer(
          studentId: studentId, amount: amount, notes: notes);
}
