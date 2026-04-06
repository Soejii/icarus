import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/schedule/data/datasource/schedule_remote_datasource.dart';
import 'package:icarus/features/schedule/data/schedule_repository_impl.dart';
import 'package:icarus/features/schedule/domain/schedule_repository.dart';
import 'package:icarus/features/schedule/domain/usecase/get_schedule_by_day_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_providers.g.dart';

@riverpod
ScheduleRemoteDataSource scheduleRemoteDataSource(Ref ref) =>
    ScheduleRemoteDataSource(ref.watch(dioProvider));

@riverpod
ScheduleRepository scheduleRepository(Ref ref) =>
    ScheduleRepositoryImpl(ref.watch(scheduleRemoteDataSourceProvider));

@riverpod
GetScheduleByDayUsecase getScheduleByDayUsecase(Ref ref) =>
    GetScheduleByDayUsecase(ref.watch(scheduleRepositoryProvider));
