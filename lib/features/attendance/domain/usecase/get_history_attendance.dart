import 'package:gaia/features/attendance/domain/attendance_repository.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetHistoryAttendanceUsecase {
  final AttendanceRepository _repository;
  GetHistoryAttendanceUsecase(this._repository);

  Future<Result<List<AttendanceEntity>>> getAttendanceHistory() async {
    return await _repository.getAttendanceHistory();
  }
}