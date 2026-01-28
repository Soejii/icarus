import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/login/data/datasource/login_remote_data_source.dart';
import 'package:gaia/features/login/data/login_repository_impl.dart';
import 'package:gaia/features/login/domain/login_repository.dart';
import 'package:gaia/features/login/domain/usecase/login_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_providers.g.dart';

@riverpod
LoginRemoteDataSource loginRemoteDatasource(Ref ref) {
  return LoginRemoteDataSource(ref.watch(dioProvider));
}

@riverpod
LoginRepository loginRepository(Ref ref) {
  return LoginRepositoryImpl(ref.watch(
    loginRemoteDatasourceProvider,
  ));
}

@riverpod
LoginUsecase loginUsecase(Ref ref) {
  return LoginUsecase(ref.watch(loginRepositoryProvider));
}
