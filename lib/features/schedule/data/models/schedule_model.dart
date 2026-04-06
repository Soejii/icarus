import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/features/schedule/data/models/teacher_model.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

@freezed
class SubjectModel with _$SubjectModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SubjectModel({
    required int id,
    required String name,
    String? iconCode,
  }) = _SubjectModel;

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
}

@freezed
class ScheduleModel with _$ScheduleModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ScheduleModel({
    required int id,
    required String day,
    required String startTime,
    required String endTime,
    required SubjectModel subject,
    required TeacherModel teacher,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}
