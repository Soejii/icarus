import 'package:icarus/features/rapor/domain/entities/rapor_history_page.dart';
import 'package:icarus/features/rapor/domain/rapor_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetRaporHistoryUsecase {
  final RaporRepository _repository;

  const GetRaporHistoryUsecase(this._repository);

  Future<Result<RaporHistoryPage>> getHistory({
    required int studentId,
    int page = 1,
  }) =>
      _repository.getHistory(studentId: studentId, page: page);
}
