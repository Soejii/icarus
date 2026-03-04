import 'package:icarus/features/profile/data/mappers/user_mapper.dart';
import 'package:icarus/features/profile/data/models/profile_model.dart';
import 'package:icarus/features/profile/domain/entities/profile_entity.dart';

extension ProfileModelMapper on ProfileModel {
  ProfileEntity toEntity() => ProfileEntity(
        name: name ?? '-',
        className: className ?? '-',
        imgUrl: photo ?? '',
        username: user?.username ?? username ?? '-',
        email: user?.email ?? email ?? '-',
        birthplace: birthplace ?? '-',
        birthdate: birthdate ?? '-',
        religion: religion ?? '-',
        address: address ?? '-',
        nik: nik ?? '-',
        phone: phone ?? '-',
        user: user?.toEntity(),
      );
}
