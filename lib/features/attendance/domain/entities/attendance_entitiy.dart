import 'package:gaia/features/attendance/domain/type/attendance_status.dart';

class AttendanceEntity {
  final int id;
  final AttendanceStatus status;
  final String date;
  final String? checkedInTime;
  final String? checkedOutTime;
  final String? notes;

  AttendanceEntity({
    required this.id,
    required this.status,
    required this.date,
    this.checkedInTime,
    this.checkedOutTime,
    this.notes,
  });
}
