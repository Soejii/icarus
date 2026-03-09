import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/performance/data/datasources/performance_remote_data_source.dart';
import 'package:icarus/features/performance/data/performance_repository_impl.dart';
import 'package:icarus/features/performance/domain/performance_repository.dart';
import 'package:icarus/features/performance/domain/usecase/get_list_class_notes_usecase.dart';
import 'package:icarus/features/performance/domain/usecase/get_list_performance_exam_usecase.dart';
import 'package:icarus/features/performance/domain/usecase/get_list_student_notes_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'performance_providers.g.dart';

@riverpod
class PerformanceTabIndex extends _$PerformanceTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}

@riverpod
PerformanceRemoteDataSource performanceRemoteDataSource(Ref ref) {
  return PerformanceRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
PerformanceRepository performanceRepository(Ref ref) {
  return PerformanceRepositoryImpl(
    ref.watch(performanceRemoteDataSourceProvider),
  );
}

@riverpod
GetListPerformanceExamUsecase getListPerformanceExamUsecase(Ref ref) {
  return GetListPerformanceExamUsecase(
    ref.watch(performanceRepositoryProvider),
  );
}

@riverpod
GetListStudentNotesUsecase getListStudentNotesUsecase(Ref ref) {
  return GetListStudentNotesUsecase(
    ref.watch(performanceRepositoryProvider),
  );
}

@riverpod
GetListClassNotesUsecase getListClassNotesUsecase(Ref ref) {
  return GetListClassNotesUsecase(
    ref.watch(performanceRepositoryProvider),
  );
}