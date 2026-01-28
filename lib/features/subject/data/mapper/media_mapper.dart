import 'package:gaia/features/subject/data/models/media_model.dart';
import 'package:gaia/features/subject/domain/types/media_type.dart';
import 'package:gaia/features/subject/domain/entities/media_entity.dart';

extension MediaMapper on MediaModel {
  MediaEntity toEntity() => MediaEntity(
        id: id,
        name: name,
        link: media,
        date: createdAt,
        type: getType(type ?? ''),
      );
}

MediaType getType(String type) {
  switch (type) {
    case 'youtube':
      return MediaType.youtube;
    case 'link':
      return MediaType.video;
    case 'instagram':
      return MediaType.pdf;
    case 'pdf':
      return MediaType.pdf;
    case 'doc':
      return MediaType.word;
    case 'ppt':
      return MediaType.ppt;
    case 'excel':
      return MediaType.excel;
    default:
      return MediaType.unknown;
  }
}
