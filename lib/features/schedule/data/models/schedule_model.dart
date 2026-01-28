import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaia/features/subject/data/models/subject_model.dart';
import 'teacher_model.dart';
part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

@freezed
class ScheduleModel with _$ScheduleModel {
  const factory ScheduleModel({
    required int id,
    required String day,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    required SubjectModel subject,
    required TeacherModel teacher,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}



