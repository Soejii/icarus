import 'package:icarus/features/absence_letter/domain/entities/absence_letter_history_page.dart';
import 'package:icarus/features/absence_letter/domain/entities/submit_absence_letter_request.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class AbsenceLetterRepository {
  Future<Result<AbsenceLetterHistoryPage>> getHistory({
    required int studentId,
    required String type,
    int page = 1,
  });

  Future<Result<void>> submit(SubmitAbsenceLetterRequest request);
}
