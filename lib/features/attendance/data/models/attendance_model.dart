import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AttendanceModel({
    required int id,
    String? status,
    String? date,
    String? checkedInTime,
    String? checkedOutTime,
    String? notes,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}
