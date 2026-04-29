import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/pusat_unduh/data/datasource/pusat_unduh_remote_data_source.dart';
import 'package:icarus/features/pusat_unduh/data/pusat_unduh_repository_impl.dart';
import 'package:icarus/features/pusat_unduh/domain/pusat_unduh_repository.dart';
import 'package:icarus/features/pusat_unduh/domain/usecase/get_list_pusat_unduh_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pusat_unduh_providers.g.dart';

@riverpod
PusatUnduhRemoteDataSource pusatUnduhRemoteDataSource(Ref ref) {
  return PusatUnduhRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
PusatUnduhRepository pusatUnduhRepository(Ref ref) {
  return PusatUnduhRepositoryImpl(
      ref.watch(pusatUnduhRemoteDataSourceProvider));
}

@riverpod
GetListPusatUnduhUsecase getListPusatUnduhUsecase(Ref ref) {
  return GetListPusatUnduhUsecase(ref.watch(pusatUnduhRepositoryProvider));
}
