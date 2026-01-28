import 'package:icarus/features/announcement/data/models/announcement_model.dart';
import 'package:icarus/features/announcement/domain/entites/announcement_entity.dart';
import 'package:icarus/shared/utils/date_helper.dart';

extension AnnouncementMapper on AnnouncementModel {
  AnnouncementEntity toEntity() => AnnouncementEntity(
        id: id,
        title: title ?? '-',
        date: formatIndoDate(startDate),
        photo: photo ?? '',
        desc: description ?? '',
      );
}
