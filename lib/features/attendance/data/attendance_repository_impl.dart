import 'package:gaia/features/attendance/data/datasource/attendance_remote_data_source.dart';
import 'package:gaia/features/attendance/data/mappers/attendance_mapper.dart';
import 'package:gaia/features/attendance/domain/attendance_repository.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/shared/core/types/result.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource _remoteDataSource;
  AttendanceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<AttendanceEntity>>> getAttendanceHistory() => guard(() async {
        final models = await _remoteDataSource.getAttendanceHistory();
        return models.map((model) => model.toEntity()).toList();
      });
}
