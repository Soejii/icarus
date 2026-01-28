import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/school/data/datasource/school_remote_data_source.dart';
import 'package:gaia/features/school/data/school_repository_impl.dart';
import 'package:gaia/features/school/domain/school_repository.dart';
import 'package:gaia/features/school/domain/usecase/get_school_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_providers.g.dart';

@riverpod
SchoolRemoteDataSource schoolRemoteDataSource(Ref ref) {
  return SchoolRemoteDataSource(
    ref.watch(
      dioProvider,
    ),
  );
}

@riverpod
SchoolRepository schoolRepository(Ref ref) {
  return SchoolRepositoryImpl(
    ref.watch(
      schoolRemoteDataSourceProvider,
    ),
  );
}

@riverpod
GetSchoolUseCase getSchoolUseCase(Ref ref) {
  return GetSchoolUseCase(
    ref.watch(
      schoolRepositoryProvider,
    ),
  );
}
