import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

@freezed
class ExamModel with _$ExamModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ExamModel({
    required int id,
    String? examTitle,
    String? startAt,
    String? examType,
    String? subjectName,
    String? status,
    int? score,
    int? kkm,
  }) = _ExamModel;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);
}
