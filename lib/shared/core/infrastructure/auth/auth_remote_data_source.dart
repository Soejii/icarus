import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_data_source.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSource(
    ref.watch(
      dioProvider,
    ),
  );
}

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);
  final Dio _dio;

  Future<String> refresh(String refreshToken) async {
    final res =
        await _dio.get('/refresh-token', data: {'refresh_token': refreshToken});
    return res.data['data']['access_token'] as String;
  }
}
