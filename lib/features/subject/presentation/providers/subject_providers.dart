import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/subject/data/datasources/subject_remote_data_source.dart';
import 'package:gaia/features/subject/data/subject_repository_impl.dart';
import 'package:gaia/features/subject/domain/subject_repository.dart';
import 'package:gaia/features/subject/domain/usecase/get_detail_sub_module_usecase.dart';
import 'package:gaia/features/subject/domain/usecase/get_detail_subject_usecase.dart';
import 'package:gaia/features/subject/domain/usecase/get_list_media_usecase.dart';
import 'package:gaia/features/subject/domain/usecase/get_list_module_usecase.dart';
import 'package:gaia/features/subject/domain/usecase/get_list_subject_exam_usecase.dart';
import 'package:gaia/features/subject/domain/usecase/get_list_subject_task_usecase.dart';
import 'package:gaia/features/subject/domain/usecase/get_list_subjects_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subject_providers.g.dart';

@riverpod
SubjectRemoteDataSource subjectRemoteDataSource(Ref ref) {
  return SubjectRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
SubjectRepository subjectRepository(Ref ref) {
  return SubjectRepositoryImpl(
    ref.watch(subjectRemoteDataSourceProvider),
  );
}

@riverpod
GetListSubjectsUsecase getListSubjectsUsecase(Ref ref) {
  return GetListSubjectsUsecase(
    ref.watch(subjectRepositoryProvider),
  );
}

@riverpod
GetListModuleUsecase getListModuleUsecase(Ref ref) {
  return GetListModuleUsecase(
    ref.watch(subjectRepositoryProvider),
  );
}

@riverpod
GetListMediaUsecase getListMediaUsecase(Ref ref) {
  return GetListMediaUsecase(
    ref.watch(subjectRepositoryProvider),
  );
}

@riverpod
GetListSubjectExamUsecase getListSubjectExamUsecase(Ref ref) {
  return GetListSubjectExamUsecase(
    ref.watch(subjectRepositoryProvider),
  );
}

@riverpod
GetListSubjectTaskUsecase getListSubjectTaskUsecase(Ref ref) {
  return GetListSubjectTaskUsecase(
    ref.watch(subjectRepositoryProvider),
  );
}

@riverpod
GetDetailSubModuleUsecase getDetailSubModuleUsecase(Ref ref) {
  return GetDetailSubModuleUsecase(ref.watch(subjectRepositoryProvider));
}

@riverpod
GetDetailSubjectUsecase getDetailSubjectUsecase(Ref ref) {
  return GetDetailSubjectUsecase(ref.watch(subjectRepositoryProvider));
}

@Riverpod(keepAlive: true)
class DetailSubjectTabIndex extends _$DetailSubjectTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}
