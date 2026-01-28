import 'package:gaia/features/discussion/data/mappers/comment_mapper.dart';
import 'package:gaia/features/discussion/data/models/detail_discussion_model.dart';
import 'package:gaia/features/discussion/domain/entity/detail_discussion_entity.dart';
import 'package:gaia/features/discussion/domain/entity/poster_discussion_entity.dart';

extension DetailDiscussionMapper on DetailDiscussionModel {
  DetailDiscussionEntity toEntity() => DetailDiscussionEntity(
        poster: PosterDiscussionEntity(
          id: id,
          text: text,
          posterName: postedBy,
          posterClass: postedByClasses,
          posterPhoto: postedByPhoto,
          posterDate: postedAt,
          likesCount: likesCount,
          commentCount: commentsCount,
        ),
        comments: comments?.map((e) => e.toEntity()).toList() ?? [],
      );
}
