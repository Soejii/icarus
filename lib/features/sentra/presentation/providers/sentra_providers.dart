import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/sentra/data/datasource/sentra_remote_data_source.dart';
import 'package:icarus/features/sentra/data/sentra_repository_impl.dart';
import 'package:icarus/features/sentra/domain/sentra_repository.dart';
import 'package:icarus/features/sentra/domain/usecase/get_list_sentra_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sentra_providers.g.dart';

@riverpod
SentraRemoteDataSource sentraRemoteDataSource(Ref ref) {
  return SentraRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
SentraRepository sentraRepository(Ref ref) {
  return SentraRepositoryImpl(ref.watch(sentraRemoteDataSourceProvider));
}

@riverpod
GetListSentraUsecase getListSentraUsecase(Ref ref) {
  return GetListSentraUsecase(ref.watch(sentraRepositoryProvider));
}
