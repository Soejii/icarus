import 'package:icarus/features/announcement/domain/entites/announcement_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class AnnouncementRepository {
  Future<Result<List<AnnouncementEntity>>> getListAnnouncement();

  Future<Result<AnnouncementEntity>> getDetail(int id);
}
