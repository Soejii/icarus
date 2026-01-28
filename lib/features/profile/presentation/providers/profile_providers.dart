import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:gaia/features/profile/data/profile_repository_impl.dart';
import 'package:gaia/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:gaia/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:gaia/features/profile/domain/profile_repository.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_providers.g.dart';

@riverpod
ProfileRemoteDatasource profileRemoteDatasource(Ref ref) {
  return ProfileRemoteDatasource(
    ref.watch(dioProvider),
  );
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(
    ref.watch(profileRemoteDatasourceProvider),
  );
}

@riverpod
GetProfile getProfile(Ref ref) {
  return GetProfile(
    ref.watch(profileRepositoryProvider),
  );
}

@riverpod
ChangePasswordUsecase changePasswordUsecase(Ref ref) {
  return ChangePasswordUsecase(
    ref.watch(profileRepositoryProvider),
  );
}
