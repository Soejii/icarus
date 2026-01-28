import 'package:gaia/features/attendance/data/models/attendance_model.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/features/attendance/domain/type/attendance_status.dart';

extension AttendanceMapper on AttendanceModel {
  AttendanceEntity toEntity() => AttendanceEntity(
        id: id,
        status: _mapStatus(status),
        date: date ?? '',
        checkedInTime: checkedInTime,
        checkedOutTime: checkedOutTime,
        notes: notes ?? '',
      );

  AttendanceStatus _mapStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'checked_in':
      case 'checkin':
      case 'masuk':
        return AttendanceStatus.checkedIn;
      case 'checked_out':
      case 'checkout':
      case 'pulang':
        return AttendanceStatus.checkedOut;
      case 'absent':
      case 'alpha':
        return AttendanceStatus.absent;
      case 'permit':
      case 'izin':
        return AttendanceStatus.permit;
      case 'sick':
      case 'sakit':
        return AttendanceStatus.sick;
      default:
        return AttendanceStatus.unknown;
    }
  }
}
