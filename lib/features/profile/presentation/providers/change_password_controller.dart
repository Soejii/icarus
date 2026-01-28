import 'package:gaia/features/profile/presentation/providers/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_password_controller.g.dart';

@riverpod
class ChangePasswordController extends _$ChangePasswordController {
  @override
  AsyncValue<String?> build() => const AsyncValue.data(null);
  
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    state = const AsyncValue.loading();

    final usecase = ref.read(changePasswordUsecaseProvider);

    final result = await usecase.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (message) => state = AsyncValue.data(message),
    );
  }
}
