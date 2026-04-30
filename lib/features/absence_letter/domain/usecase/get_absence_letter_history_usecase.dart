import 'package:icarus/features/absence_letter/domain/absence_letter_repository.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_history_page.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetAbsenceLetterHistoryUsecase {
  final AbsenceLetterRepository _repository;

  const GetAbsenceLetterHistoryUsecase(this._repository);

  Future<Result<AbsenceLetterHistoryPage>> getHistory({
    required int studentId,
    required String type,
    int page = 1,
  }) {
    return _repository.getHistory(
      studentId: studentId,
      type: type,
      page: page,
    );
  }
}
