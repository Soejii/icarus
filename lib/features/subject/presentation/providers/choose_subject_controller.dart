import 'package:gaia/features/subject/domain/entities/subject_entity.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'choose_subject_controller.g.dart';

@riverpod
class ChooseSubjectController extends _$ChooseSubjectController {
  @override
  Future<List<SubjectEntity>> build() {
    return _fetch();
  }

  Future<List<SubjectEntity>> _fetch() async {
    final useCase = ref.read(getListSubjectsUsecaseProvider);
    final res = await useCase.getAllSubject();

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }
}
