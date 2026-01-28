import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/attendance/data/attendance_repository_impl.dart';
import 'package:gaia/features/attendance/data/datasource/attendance_remote_data_source.dart';
import 'package:gaia/features/attendance/domain/attendance_repository.dart';
import 'package:gaia/features/attendance/domain/usecase/get_history_attendance.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attedance_providers.g.dart';

@riverpod
AttendanceRemoteDataSource attendanceRemoteDataSource(Ref ref) {
  return AttendanceRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
AttendanceRepository attendanceRepository(Ref ref) {
  return AttendanceRepositoryImpl(
    ref.watch(attendanceRemoteDataSourceProvider),
  );
}

@riverpod
GetHistoryAttendanceUsecase getHistoryAttendanceUsecase(Ref ref) {
  return GetHistoryAttendanceUsecase(
    ref.watch(attendanceRepositoryProvider),
  );
}

@riverpod
class AttendanceTabIndex extends _$AttendanceTabIndex {
  @override
  int build() => 0;

  void set(int index) => state = index;
}