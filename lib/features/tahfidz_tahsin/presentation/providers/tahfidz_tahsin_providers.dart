import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/tahfidz_tahsin/data/datasource/tahfidz_tahsin_remote_data_source.dart';
import 'package:icarus/features/tahfidz_tahsin/data/tahfidz_tahsin_repository_impl.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/tahfidz_tahsin_repository.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/usecase/get_list_tahfidz_usecase.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/usecase/get_list_tahsin_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tahfidz_tahsin_providers.g.dart';

@riverpod
TahfidzTahsinRemoteDataSource tahfidzTahsinRemoteDataSource(Ref ref) {
  return TahfidzTahsinRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
TahfidzTahsinRepository tahfidzTahsinRepository(Ref ref) {
  return TahfidzTahsinRepositoryImpl(
    ref.watch(tahfidzTahsinRemoteDataSourceProvider),
  );
}

@riverpod
GetListTahfidzUsecase getListTahfidzUsecase(Ref ref) {
  return GetListTahfidzUsecase(ref.watch(tahfidzTahsinRepositoryProvider));
}

@riverpod
GetListTahsinUsecase getListTahsinUsecase(Ref ref) {
  return GetListTahsinUsecase(ref.watch(tahfidzTahsinRepositoryProvider));
}

@riverpod
class TahfidzTahsinTabIndex extends _$TahfidzTahsinTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}
