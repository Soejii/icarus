import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListSubjectsUsecase {
  final SubjectRepository _repository;
  GetListSubjectsUsecase(this._repository);

  Future<Result<List<SubjectEntity>>> getAllSubject() async {
    return await _repository.getAllSubject();
  }
}
