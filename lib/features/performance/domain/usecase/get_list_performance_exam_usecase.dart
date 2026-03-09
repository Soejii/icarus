import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/shared/core/domain/entities/exam_entity.dart';
import 'package:icarus/shared/core/domain/types/exam_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListPerformanceExamUsecase {
  final PerformanceRepository _repository;
  GetListPerformanceExamUsecase(this._repository);

  Future<Result<List<ExamEntity>>> getListPerformanceExam({
    required int idStudent,
    required ExamType examType,
    required int page,
  }) async {
    return await _repository.getListExam(
      examType: examType,
      idStudent: idStudent,
      page: page,
    );
  }
}
