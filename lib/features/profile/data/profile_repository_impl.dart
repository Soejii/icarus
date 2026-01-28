import 'package:icarus/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:icarus/features/profile/data/mappers/profile_mapper.dart';
import 'package:icarus/features/profile/domain/entities/profile_entity.dart';
import 'package:icarus/features/profile/domain/profile_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _datasource;
  ProfileRepositoryImpl(this._datasource);

  @override
  Future<Result<ProfileEntity>> getProfile() => guard(
        () async {
          final models = await _datasource.getProfile();
          return models.toEntity();
        },
      );

  @override
  Future<Result<String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) => guard(
        () async {
          return await _datasource.changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword,
          );
        },
      );
}
