import 'package:gaia/features/discussion/domain/entity/comment_entity.dart';
import 'package:gaia/features/discussion/domain/entity/poster_discussion_entity.dart';

class DiscussionEntity {
  final PosterDiscussionEntity? poster;
  final CommentEntity? comment;

  DiscussionEntity({
    required this.poster,
    required this.comment,
  });
}
