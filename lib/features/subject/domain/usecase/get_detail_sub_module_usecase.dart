import 'package:gaia/features/subject/domain/entities/detail_sub_module_entity.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetDetailSubModuleUsecase {
  final SubjectRepository _repository;
  GetDetailSubModuleUsecase(this._repository);

  Future<Result<DetailSubModuleEntity>> getDetailSubModule(int id) async {
    return await _repository.getDetailSubModule(id);
  }
}
