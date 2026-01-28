import 'package:gaia/features/discussion/domain/discussion_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class CreateCommentUsecase {
  final DiscussionRepository _repository;
  CreateCommentUsecase(this._repository);

  Future<Result<Unit>> createComment(
    String text,
    int discussionId
   ) async {
    return await _repository.createComment(text, discussionId);
  }
}
