import 'package:gaia/features/login/domain/entities/login_entity.dart';
import 'package:gaia/features/login/presentation/providers/login_providers.dart';
import 'package:gaia/shared/core/infrastructure/analytics/analytics_providers.dart';
import 'package:gaia/shared/core/infrastructure/auth/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<LoginEntity?> build() => null;

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();

    final res = await ref.read(loginUsecaseProvider).login(username, password);
    final analytics = ref.read(analyticsTrackerProvider);

    res.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (entity) async {
        await ref
            .read(authStateProvider.notifier)
            .setAuthenticated(entity.token);

        await analytics.trackEvent(
          'login_success',
        );

        final schoolName = entity.schoolName;
        final schoolId = entity.schoolId;
        if (schoolName.isNotEmpty) {
          await analytics.setUserProperty('school_name', schoolName);
          await analytics.setUserProperty('school_id', schoolId.toString());
          await analytics.setUserId(entity.userId.toString());
        }

        state = AsyncData(entity);
      },
    );
  }
}
