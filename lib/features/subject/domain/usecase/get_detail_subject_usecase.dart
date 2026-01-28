import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetDetailSubjectUsecase {
  final SubjectRepository _repository;
  GetDetailSubjectUsecase(this._repository);

  Future<Result<SubjectEntity>> getDetailSubject(int subjectId) async {
    return await _repository.getDetailSubject(subjectId);
  }
}
