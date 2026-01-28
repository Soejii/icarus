import 'package:icarus/features/announcement/domain/announcement_repository.dart';
import 'package:icarus/features/announcement/domain/entites/announcement_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListAnnouncementUsecase {
  final AnnouncementRepository _repository;
  GetListAnnouncementUsecase(this._repository);

  Future<Result<List<AnnouncementEntity>>> getListAnnouncement() {
    return _repository.getListAnnouncement();
  }
}
