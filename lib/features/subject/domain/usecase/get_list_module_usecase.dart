import 'package:gaia/features/subject/domain/entities/module_entity.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListModuleUsecase {
  final SubjectRepository _repository;
  GetListModuleUsecase(this._repository);

  Future<Result<List<ModuleEntity>>> getListModule(int subjectId) async {
    return await _repository.getListModule(subjectId);
  }
}
