import 'package:gaia/features/discussion/domain/discussion_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class CreateDiscussionUsecase {
  final DiscussionRepository _repository;
  CreateDiscussionUsecase(this._repository);

  Future<Result<Unit>> createDiscussion(
    String type,
    String text, {
    int? subjectId,
  }) async {
    return await _repository.createDiscussion(type, text, subjectId: subjectId);
  }
}
