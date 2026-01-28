import 'package:gaia/features/announcement/domain/entites/announcement_entity.dart';
import 'package:gaia/features/announcement/presentation/providers/announcement_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_announcement_controller.g.dart';

@riverpod
class DetailAnnouncementController extends _$DetailAnnouncementController {
    @override
  Future<AnnouncementEntity> build(int id) async {
    final usecase = ref.read(getDetailAnnouncementUsecaseProvider);
    final res = await usecase.getDetail(id);

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }
}