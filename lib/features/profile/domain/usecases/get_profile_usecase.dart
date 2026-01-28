import 'package:icarus/features/profile/domain/entities/profile_entity.dart';
import 'package:icarus/features/profile/domain/profile_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetProfile {
  final ProfileRepository _repository;
  GetProfile(this._repository);

  Future<Result<ProfileEntity>> getProfile() async{
    return await _repository.getProfile();
  }
}
