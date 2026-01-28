import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaia/features/discussion/data/models/comment_model.dart';

part 'detail_discussion_model.g.dart';
part 'detail_discussion_model.freezed.dart';

@freezed
class DetailDiscussionModel with _$DetailDiscussionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DetailDiscussionModel({
    required int id,
    String? text,
    String? postedBy,
    String? postedByClasses,
    String? postedByPhoto,
    String? postedAt,
    int? commentsCount,
    int? likesCount,
    List<CommentModel>? comments,
  }) = _DetailDiscussionModel;

  factory DetailDiscussionModel.fromJson(Map<String, dynamic> json) =>
      _$DetailDiscussionModelFromJson(json);
}
