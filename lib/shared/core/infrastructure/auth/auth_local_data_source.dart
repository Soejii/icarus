import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_data_source.g.dart';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSource(
    ref.watch(secureStorageProvider),
  );
}

class AuthLocalDataSource {
  const AuthLocalDataSource(this._storage);

  final FlutterSecureStorage _storage;

  static const _kAccessToken = 'access_token';

  Future<void> saveTokens({
    required String access,
  }) async {
    await _storage.write(key: _kAccessToken, value: access);
  }

  Future<String?> readAccessToken() => _storage.read(key: _kAccessToken);

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
