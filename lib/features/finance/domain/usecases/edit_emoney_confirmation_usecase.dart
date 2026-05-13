import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class EditEmoneyConfirmationUsecase {
  final EmoneyRepository _repository;
  EditEmoneyConfirmationUsecase(this._repository);

  Future<Result<void>> call({
    required int emoneyId,
    required String filePath,
  }) =>
      _repository.editConfirmation(emoneyId: emoneyId, filePath: filePath);
}
