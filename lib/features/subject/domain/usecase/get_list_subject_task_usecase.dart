import 'package:gaia/shared/core/domain/entities/task_entity.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListSubjectTaskUsecase {
  final SubjectRepository _repository;
  GetListSubjectTaskUsecase(this._repository);

  Future<Result<List<TaskEntity>>> getTasks(int idSubject,{int? page}) async {
    return await _repository.getListTask(idSubject,page: page);
  }
}
