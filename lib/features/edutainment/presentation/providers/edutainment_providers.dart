import 'package:gaia/features/edutainment/data/datasources/edutainment_remote_data_source.dart';
import 'package:gaia/features/edutainment/data/edutainment_repository_impl.dart';
import 'package:gaia/features/edutainment/domain/edutainment_repository.dart';
import 'package:gaia/features/edutainment/domain/usecase/get_detail_edutainment_usecase.dart';
import 'package:gaia/features/edutainment/domain/usecase/get_list_digital_magazine_usecase.dart';
import 'package:gaia/features/edutainment/domain/usecase/get_list_edutainment_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edutainment_providers.g.dart';

@riverpod
EdutainmentRemoteDataSource edutainmentRemoteDataSource(Ref ref) {
  return EdutainmentRemoteDataSource(
    ref.watch(
      dioProvider,
    ),
  );
}

@riverpod
EdutainmentRepository edutainmentRepository(Ref ref) {
  return EdutainmentRepositoryImpl(
    ref.watch(
      edutainmentRemoteDataSourceProvider,
    ),
  );
}

@riverpod
class EdutainmentTabIndex extends _$EdutainmentTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}

@riverpod
GetListEdutainmentUsecase getListEdutainmentUsecase(Ref ref) {
  return GetListEdutainmentUsecase(
    ref.watch(
      edutainmentRepositoryProvider,
    ),
  );
}

@riverpod
GetListDigitalMagazineUsecase getListDigitalMagazineUsecase(Ref ref) {
  return GetListDigitalMagazineUsecase(
    ref.watch(
      edutainmentRepositoryProvider,
    ),
  );
}

@riverpod
GetDetailEdutainmentUsecase getDetailEdutainmentUsecase(Ref ref) {
  return GetDetailEdutainmentUsecase(
    ref.watch(edutainmentRepositoryProvider),
  );
}
