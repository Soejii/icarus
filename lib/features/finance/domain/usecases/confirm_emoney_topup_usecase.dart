import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class ConfirmEmoneyTopupUsecase {
  final EmoneyRepository _repository;
  ConfirmEmoneyTopupUsecase(this._repository);

  Future<Result<void>> call({
    required int emoneyId,
    required String filePath,
  }) =>
      _repository.confirmTopup(emoneyId: emoneyId, filePath: filePath);
}
