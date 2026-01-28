import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/schedule/data/datasource/schedule_remote_datasource.dart';
import 'package:gaia/features/schedule/data/schedule_repository_impl.dart';
import 'package:gaia/features/schedule/domain/schedule_repository.dart';
import 'package:gaia/features/schedule/domain/usecase/get_schedule_by_day_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_providers.g.dart';

@riverpod
ScheduleRemoteDataSource scheduleRemoteDataSource(Ref ref) {
  return ScheduleRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
ScheduleRepository scheduleRepository(Ref ref) {
  return ScheduleRepositoryImpl(
    ref.watch(scheduleRemoteDataSourceProvider),
  );
}

@riverpod
GetScheduleByDayUsecase getScheduleByDayUseCase(Ref ref) {
  return GetScheduleByDayUsecase(
    ref.watch(scheduleRepositoryProvider),
  );
}