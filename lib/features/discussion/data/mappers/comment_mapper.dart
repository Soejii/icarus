import 'package:gaia/features/discussion/data/models/comment_model.dart';
import 'package:gaia/features/discussion/domain/entity/comment_entity.dart';

extension CommentMapper on CommentModel {
  CommentEntity toEntity() => CommentEntity(
        id: id,
        text: text,
        posterName: postedBy,
        posterPhoto: postedByPhoto,
        posterDate: postedAt,
      );
}
