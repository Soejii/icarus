import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/activity/data/activity_repository_impl.dart';
import 'package:gaia/features/activity/data/datasources/activity_remote_data_source.dart';
import 'package:gaia/features/activity/domain/activity_repository.dart';
import 'package:gaia/features/activity/domain/usecase/get_list_exam_usecase.dart';

import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_providers.g.dart';

@riverpod
ActivityRemoteDataSource activityRemoteDataSource(Ref ref) {
  return ActivityRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
ActivityRepository activityRepository(Ref ref) {
  return ActivityRepositoryImpl(
    ref.watch(activityRemoteDataSourceProvider),
  );
}

@riverpod
GetListExamUsecase getListExamUsecase(Ref ref) {
  return GetListExamUsecase(
    ref.watch(activityRepositoryProvider),
  );
}

@riverpod
class ActivityTabIndex extends _$ActivityTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}
