import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaskModel({
    required int id,
    String? title,
    String? subject,
    int? score,
    String? status,
    String? date,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
