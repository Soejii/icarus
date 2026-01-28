import 'package:icarus/features/profile/domain/profile_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class ChangePasswordUsecase {
  final ProfileRepository _repository;

  ChangePasswordUsecase(this._repository);

  Future<Result<String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
