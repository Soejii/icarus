import 'package:icarus/features/profile/data/models/user_model.dart';
import 'package:icarus/features/profile/domain/entities/user_entity.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() => UserEntity(
        userId: id,
        username: username ?? '-',
        email: email ?? '-',
        name: name ?? '-',
        imgUrl: picture ?? '',
      );
}
