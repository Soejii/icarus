import 'package:gaia/features/login/data/models/login_model.dart';
import 'package:gaia/features/login/domain/entities/login_entity.dart';

extension LoginResponseMapper on LoginResponseModel {
  LoginEntity toEntity() => LoginEntity(
        token: accessToken,
        schoolName: school?.name ?? '${school?.id}',
        schoolId: school?.id ?? 69420,
        userId: user?.id ?? 0
      );
}
