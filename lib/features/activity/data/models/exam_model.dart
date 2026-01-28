import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

@freezed
class ExamModel with _$ExamModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ExamModel({
    required int id,
    String? title,
    String? startAt,
    String? subject,
    String? status,
    int? score,
  }) = _ExamModel;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);
}
