import 'package:gaia/features/discussion/domain/discussion_repository.dart';
import 'package:gaia/features/discussion/domain/entity/detail_discussion_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetDetailDiscussionUsecase {
  final DiscussionRepository _repository;
  GetDetailDiscussionUsecase(this._repository);

  Future<Result<DetailDiscussionEntity>> getDetailDiscussion(
      int idDiscussion) async {
    return await _repository.getDetailDiscussion(idDiscussion);
  }
}
