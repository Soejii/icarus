import 'package:icarus/features/profile/domain/entities/profile_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class ProfileRepository {
  Future<Result<ProfileEntity>> getProfile();
  Future<Result<String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
