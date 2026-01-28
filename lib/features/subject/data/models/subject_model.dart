import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_model.g.dart';
part 'subject_model.freezed.dart';

@freezed
class SubjectModel with _$SubjectModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SubjectModel({
    required int id,
    String? name,
    String? iconCode,
  }) = _SubjectModel;
  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
}
