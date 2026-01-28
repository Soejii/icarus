import 'package:gaia/features/announcement/domain/entites/announcement_entity.dart';
import 'package:gaia/features/announcement/presentation/providers/announcement_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_controller.g.dart';

@Riverpod(keepAlive: true)
class AnnouncementController extends _$AnnouncementController {
  @override
  Future<List<AnnouncementEntity>> build() async {
    final usecase = ref.read(getListAnnouncementUsecaseProvider);
    final res = await usecase.getListAnnouncement();

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }
}
