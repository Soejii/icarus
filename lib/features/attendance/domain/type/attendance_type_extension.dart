import 'attendance_type.dart';

extension AttendanceTypeExtension on AttendanceType {
  String get displayName {
    switch (this) {
      case AttendanceType.history:
        return 'Riwayat Kehadiran';
      case AttendanceType.calendar:
        return 'Kalender Kehadiran';
    }
  }
}