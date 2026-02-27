import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/domain/entities/exam_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListPerformanceExam {
  final PerformanceRepository _repository;
  GetListPerformanceExam(this._repository);

  Future<Result<List<ExamEntity>>> getListPerformanceExam() async {
    return await _repository.getListExam();
  }
}
