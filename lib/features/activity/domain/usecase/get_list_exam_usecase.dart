import 'package:gaia/features/activity/domain/activity_repository.dart';
import 'package:gaia/shared/core/domain/entities/exam_entity.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListExamUsecase {
  final ActivityRepository _repository;
  GetListExamUsecase(this._repository);

  Future<Result<List<ExamEntity>>> getExam(ExamType type, {int? page}) async {
    return await _repository.getExam(type, page: page);
  }
}
