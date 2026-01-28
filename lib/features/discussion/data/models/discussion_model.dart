import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaia/features/discussion/data/models/comment_model.dart';

part 'discussion_model.g.dart';
part 'discussion_model.freezed.dart';

@freezed
class DiscussionModel with _$DiscussionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DiscussionModel({
    required int id,
    String? text,
    String? postedBy,
    String? postedByClasses,
    String? postedByPhoto,
    String? postedAt,
    int? commentsCount,
    int? likesCount,
    CommentModel? lastComment,
  }) = _DiscussionModel;

  factory DiscussionModel.fromJson(Map<String, dynamic> json) =>
      _$DiscussionModelFromJson(json);
}
