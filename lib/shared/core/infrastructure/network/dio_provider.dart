import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/shared/core/infrastructure/auth/auth_local_data_source.dart';
import 'package:gaia/shared/core/infrastructure/network/api_client.dart';
import 'package:gaia/shared/core/infrastructure/network/config_provider.dart';
import 'package:gaia/shared/core/infrastructure/network/interceptors/auth_interceptors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final env = ref.watch(appConfigProvider);
  final storage = ref.watch(authLocalDataSourceProvider);
  final baseUrl = env.baseUrl.toString();

  final dio = ApiClient.build(baseUrl: baseUrl, token: null);
  dio.interceptors.addAll(
    [
      AuthInterceptor(storage),
    ],
  );
  return dio;
}
