import 'package:dio/dio.dart';
import 'package:icarus/features/profile/data/models/profile_model.dart';

class ProfileRemoteDatasource {
  final Dio _dio;
  ProfileRemoteDatasource(this._dio);

  Future<ProfileModel> getProfile() async {
    final res = await _dio.get('/profile');
    return ProfileModel.fromJson(res.data['data']);
  }

  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final res = await _dio.post(
      '/change-pass',
      data: {
        'old_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      },
    );
    return res.data['message'] ?? 'Password berhasil diubah';
  }
}
