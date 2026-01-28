import 'package:gaia/features/login/domain/entities/login_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

abstract class LoginRepository {
  Future<Result<LoginEntity>> login(String username, String password);
}
