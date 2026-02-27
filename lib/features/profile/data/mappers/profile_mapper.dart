import 'package:icarus/features/profile/data/mappers/user_mapper.dart';
import 'package:icarus/features/profile/data/models/profile_model.dart';
import 'package:icarus/features/profile/domain/entities/profile_entity.dart';

extension ProfileModelMapper on ProfileModel {
  ProfileEntity toEntity() => ProfileEntity(
        userId: id,
        name: name ?? '-',
        className: className ?? '-',
        imgUrl: photo ?? '',
        username: user?.username ?? username ?? '-',
        email: user?.email ?? email ?? '-',
        nis: nis ?? '-',
        nisn: nisn ?? '-',
        birthplace: birthplace ?? '-',
        birthdate: birthdate ?? '-',
        gender: gender ?? '-',
        religion: religion ?? '-',
        address: address ?? '-',
        rt: rt ?? '-',
        rw: rw ?? '-',
        dusun: dusun ?? '-',
        kelurahan: kelurahan ?? '-',
        kecamatan: kecamatan ?? '-',
        codePos: codePos ?? '-',
        schoolOrigin: schoolOrigin ?? '-',
        nik: nik ?? '-',
        phone: phone ?? '-',
        user: user?.toEntity(),
      );
}
