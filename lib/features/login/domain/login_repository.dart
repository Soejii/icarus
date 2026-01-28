import 'package:icarus/features/login/domain/entities/login_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class LoginRepository {
  Future<Result<LoginEntity>> login(String username, String password);
}
