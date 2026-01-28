import 'package:gaia/features/announcement/domain/announcement_repository.dart';
import 'package:gaia/features/announcement/domain/entites/announcement_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListAnnouncementUsecase {
  final AnnouncementRepository _repository;
  GetListAnnouncementUsecase(this._repository);

  Future<Result<List<AnnouncementEntity>>> getListAnnouncement() {
    return _repository.getListAnnouncement();
  }
}
