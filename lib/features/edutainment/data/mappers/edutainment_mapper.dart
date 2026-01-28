import 'package:gaia/features/edutainment/data/models/edutainment_model.dart';
import 'package:gaia/features/edutainment/domain/entities/edutainment_entity.dart';

extension EdutainmentMapper on EdutainmentModel {
  EdutainmentEntity toEntity() => EdutainmentEntity(
        id: id,
        photo: thumbnail ?? '',
        title: title ?? '-',
        date: createdAt ?? '',
        link: link ?? '',
        desc: description ?? '',
      );
}
