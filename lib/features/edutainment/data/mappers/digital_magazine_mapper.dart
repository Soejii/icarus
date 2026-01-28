import 'package:icarus/features/edutainment/data/models/digital_magazine_model.dart';
import 'package:icarus/features/edutainment/domain/entities/digital_magazine_entity.dart';

extension DigitalMagazineMapper on DigitalMagazineModel {
  DigitalMagazineEntity toEntity() => DigitalMagazineEntity(
        id: id,
        photo: photo,
      );
}
