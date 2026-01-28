import 'package:gaia/features/login/domain/entities/login_entity.dart';
import 'package:gaia/features/login/domain/login_repository.dart';
import 'package:gaia/shared/core/types/result.dart';

class LoginUsecase {
  final LoginRepository _repository;
  LoginUsecase(this._repository);

  Future<Result<LoginEntity>> login(String username, String password) async {
    return await _repository.login(username, password);
  }
}
