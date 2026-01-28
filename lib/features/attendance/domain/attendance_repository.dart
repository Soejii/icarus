import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class AttendanceRepository {
  Future<Result<List<AttendanceEntity>>> getAttendanceHistory();
}