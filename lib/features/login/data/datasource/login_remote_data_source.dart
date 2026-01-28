import 'package:dio/dio.dart';
import 'package:gaia/features/login/data/models/login_model.dart';

class LoginRemoteDataSource {
  final Dio _dio;
  LoginRemoteDataSource(this._dio);

  Future<LoginResponseModel> login(
    String username,
    String password,
  ) async {
    final res = await _dio.post(
      '/login',
      data: {
        "username": username,
        "password": password,
      },
    );
    return LoginResponseModel.fromJson(res.data['data']);
  }
}
