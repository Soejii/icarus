import 'package:icarus/features/absence_letter/data/datasource/absence_letter_remote_data_source.dart';
import 'package:icarus/features/absence_letter/data/mappers/absence_letter_mapper.dart';
import 'package:icarus/features/absence_letter/domain/absence_letter_repository.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_history_page.dart';
import 'package:icarus/features/absence_letter/domain/entities/submit_absence_letter_request.dart';
import 'package:icarus/shared/core/types/result.dart';

class AbsenceLetterRepositoryImpl implements AbsenceLetterRepository {
  final AbsenceLetterRemoteDataSource _dataSource;

  const AbsenceLetterRepositoryImpl(this._dataSource);

  @override
  Future<Result<AbsenceLetterHistoryPage>> getHistory({
    required int studentId,
    required String type,
    int page = 1,
  }) =>
      guard(
        () async {
          final pageModel = await _dataSource.getHistory(
            studentId: studentId,
            type: type,
            page: page,
          );
          return pageModel.toEntity();
        },
      );

  @override
  Future<Result<void>> submit(SubmitAbsenceLetterRequest request) =>
      guard(() => _dataSource.submit(request));
}
