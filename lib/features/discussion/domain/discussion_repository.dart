import 'package:gaia/features/discussion/domain/entity/detail_discussion_entity.dart';
import 'package:gaia/features/discussion/domain/entity/discussion_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class DiscussionRepository {
  Future<Result<List<DiscussionEntity>>> getListDiscussion(
    String type,
    int page, {
    int? idSubject,
  });

  Future<Result<DetailDiscussionEntity>> getDetailDiscussion(int idDiscussion);

  Future<Result<Unit>> createDiscussion(String type, String text,
      {int? subjectId,});
  Future<Result<Unit>> createComment(String text, int discussionId);
}
