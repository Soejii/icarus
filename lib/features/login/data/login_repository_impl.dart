import 'package:icarus/features/login/data/datasource/login_remote_data_source.dart';
import 'package:icarus/features/login/data/mappers/login_mapper.dart';
import 'package:icarus/features/login/domain/entities/login_entity.dart';
import 'package:icarus/features/login/domain/login_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _datasource;
  LoginRepositoryImpl(this._datasource);

  @override
  Future<Result<LoginEntity>> login(String username, String password) => guard(
        () async {
          final models = await _datasource.login(username, password);
          return models.toEntity();
        },
      );
}
