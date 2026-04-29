import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/konseling/data/datasource/konseling_remote_data_source.dart';
import 'package:icarus/features/konseling/data/konseling_repository_impl.dart';
import 'package:icarus/features/konseling/domain/konseling_repository.dart';
import 'package:icarus/features/konseling/domain/usecase/get_detail_konseling_usecase.dart';
import 'package:icarus/features/konseling/domain/usecase/get_list_konseling_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'konseling_providers.g.dart';

@riverpod
KonselingRemoteDataSource konselingRemoteDataSource(Ref ref) {
  return KonselingRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
KonselingRepository konselingRepository(Ref ref) {
  return KonselingRepositoryImpl(ref.watch(konselingRemoteDataSourceProvider));
}

@riverpod
GetListKonselingUsecase getListKonselingUsecase(Ref ref) {
  return GetListKonselingUsecase(ref.watch(konselingRepositoryProvider));
}

@riverpod
GetDetailKonselingUsecase getDetailKonselingUsecase(Ref ref) {
  return GetDetailKonselingUsecase(ref.watch(konselingRepositoryProvider));
}
