import 'package:dio/dio.dart';
import 'package:gaia/shared/core/infrastructure/auth/auth_local_data_source.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storage);
  final AuthLocalDataSource _storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.readAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
