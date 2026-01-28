import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_subject_controller.g.dart';

@riverpod
class DetailSubjectController extends _$DetailSubjectController {
  @override
  Future<SubjectEntity> build(int subjectId) {
    return _fetch(subjectId);
  }

  Future<SubjectEntity> _fetch(int subjectId) async {
    final useCase = ref.read(getDetailSubjectUsecaseProvider);
    final res = await useCase.getDetailSubject(subjectId);

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }
}
