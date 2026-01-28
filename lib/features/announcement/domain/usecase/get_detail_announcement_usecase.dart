import 'package:icarus/features/announcement/domain/announcement_repository.dart';
import 'package:icarus/features/announcement/domain/entites/announcement_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetDetailAnnouncementUsecase {
  final AnnouncementRepository _repository;
  GetDetailAnnouncementUsecase(this._repository);

  Future<Result<AnnouncementEntity>> getDetail(int id) async {
    return await _repository.getDetail(id);
  }
}
