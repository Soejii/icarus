import 'package:gaia/features/discussion/domain/entity/comment_entity.dart';
import 'package:gaia/features/discussion/domain/entity/poster_discussion_entity.dart';

class DetailDiscussionEntity {
  final PosterDiscussionEntity? poster;
  final List<CommentEntity>? comments;

  DetailDiscussionEntity({
    required this.poster,
    required this.comments,
  });
}
