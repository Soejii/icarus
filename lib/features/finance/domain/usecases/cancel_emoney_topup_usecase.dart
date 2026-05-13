import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class CancelEmoneyTopupUsecase {
  final EmoneyRepository _repository;
  CancelEmoneyTopupUsecase(this._repository);

  Future<Result<void>> call(int emoneyId) =>
      _repository.cancelTopup(emoneyId);
}
