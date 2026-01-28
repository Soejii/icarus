import 'package:gaia/features/subject/domain/entities/media_entity.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListMediaUsecase {
  final SubjectRepository _repository;
  GetListMediaUsecase(this._repository);

  Future<Result<List<MediaEntity>>> getListMedia(int subjectId) async {
    return await _repository.getListMedia(subjectId);
  }
}
