import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_task_model.g.dart';
part 'detail_task_model.freezed.dart';

@freezed
class DetailTaskModel with _$DetailTaskModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DetailTaskModel({
    required int id,
    String? title,
    String? teacherNotes,
    String? studentNotes,
    String? file,
    int? score,
    String? instruction,
    String? startAt,
    String? finishAt,
    String? dateSubmit,
    String? teacherName,
  }) = _DetailTaskModel;

  factory DetailTaskModel.fromJson(Map<String, dynamic> json) =>
      _$DetailTaskModelFromJson(json);
}
