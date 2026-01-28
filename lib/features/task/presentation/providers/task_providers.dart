import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/task/data/datasources/task_remote_data_source.dart';
import 'package:gaia/features/task/data/task_repository_impl.dart';
import 'package:gaia/features/task/domain/task_repository.dart';
import 'package:gaia/features/task/domain/usecase/get_detail_task_usecase.dart';
import 'package:gaia/features/task/domain/usecase/get_list_task_usecase.dart';
import 'package:gaia/features/task/domain/usecase/submit_task_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_providers.g.dart';

@riverpod
TaskRemoteDataSource taskRemoteDataSource(Ref ref) {
  return TaskRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(
    ref.watch(taskRemoteDataSourceProvider),
  );
}

@riverpod
GetListTaskUsecase getListTaskUsecase(Ref ref) {
  return GetListTaskUsecase(
    ref.watch(taskRepositoryProvider),
  );
}

@riverpod
GetDetailTaskUsecase getDetailTaskUsecase(Ref ref) {
  return GetDetailTaskUsecase(
    ref.watch(taskRepositoryProvider),
  );
}

@riverpod
SubmitTaskUsecase submitTaskUsecase(Ref ref) {
  return SubmitTaskUsecase(
    ref.watch(taskRepositoryProvider),
  );
}
