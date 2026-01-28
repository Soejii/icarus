import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.g.dart';
part 'comment_model.freezed.dart';

@freezed
class CommentModel with _$CommentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CommentModel({
    required int id,
    String? text,
    String? postedBy,
    String? postedByPhoto,
    String? postedAt,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
