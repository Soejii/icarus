


import 'package:icarus/features/school/domain/entities/school_entity.dart';
import 'package:icarus/features/school/data/models/school_model.dart';

extension SchoolEntityMapper on SchoolModel {
  SchoolEntity toEntity() => SchoolEntity(
        id: id,
        name: name ?? '-',
        address: address ?? '-',
        description: description ?? '-',
        email: email ?? '-',
        facebook: facebook ?? '-',
        instagram: instagram ?? '-',
        phone: phone ?? '-',
        photo: photo ?? '-',
        registrationNumber: registrationNumber ?? '-',
        website: website ?? '-',
        youtube: youtube ?? '-',
        accreditation: accreditation ?? '-',
      );
}