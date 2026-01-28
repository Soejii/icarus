import 'package:icarus/shared/core/infrastructure/analytics/analytics_providers.dart';
import 'package:icarus/shared/core/infrastructure/auth/auth_remote_data_source.dart';
import 'package:icarus/shared/core/infrastructure/auth/auth_session_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_state_provider.g.dart';

enum AuthStatus { unauthenticated, authenticated }

@riverpod
class AuthState extends _$AuthState {
  @override
  Future<AuthStatus> build() async {
    final session = ref.read(authSessionProvider);
    final remote = ref.read(authRemoteDataSourceProvider);

    final cached = await session.readToken();
    if (cached == null) return AuthStatus.unauthenticated;

    try {
      final newToken = await remote.refresh(cached);
      await session.saveToken(newToken);
      return AuthStatus.authenticated;
    } catch (e) {
      await session.clear();
      return AuthStatus.unauthenticated;
    }
  }

  Future<void> setAuthenticated(String token) async {
    await ref.read(authSessionProvider).saveToken(token);
    state = const AsyncData(AuthStatus.authenticated);
  }

  Future<void> logout() async {
    final analytics = ref.read(analyticsTrackerProvider);
    await ref.read(authSessionProvider).clear();
    await analytics.clearData();
    state = const AsyncData(AuthStatus.unauthenticated);
  }
}
