import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/shared/core/infrastructure/auth/auth_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_provider.g.dart';

@riverpod
AuthSession authSession(Ref ref) {
  return AuthSession(ref.watch(authLocalDataSourceProvider));
}

class AuthSession {
  AuthSession(this._storage);
  final AuthLocalDataSource _storage;

  Future<String?> readToken() => _storage.readAccessToken();
  Future<void> saveToken(String token) => _storage.saveTokens(access: token);
  Future<void> clear() => _storage.clear();
}
