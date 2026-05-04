import 'package:icarus/features/rapor/domain/entities/rapor_history_page.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class RaporRepository {
  Future<Result<RaporHistoryPage>> getHistory({
    required int studentId,
    int page = 1,
  });
}
