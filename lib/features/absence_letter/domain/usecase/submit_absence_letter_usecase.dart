import 'package:icarus/features/absence_letter/domain/absence_letter_repository.dart';
import 'package:icarus/features/absence_letter/domain/entities/submit_absence_letter_request.dart';
import 'package:icarus/shared/core/types/result.dart';

class SubmitAbsenceLetterUsecase {
  final AbsenceLetterRepository _repository;

  const SubmitAbsenceLetterUsecase(this._repository);

  Future<Result<void>> submit(SubmitAbsenceLetterRequest request) {
    return _repository.submit(request);
  }
}
