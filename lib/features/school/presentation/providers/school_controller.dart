import 'package:gaia/features/school/domain/entities/school_entity.dart';
import 'package:gaia/features/school/presentation/providers/school_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'school_controller.g.dart';

@Riverpod(keepAlive: true)
class SchoolController extends _$SchoolController {
  @override
  Future<SchoolEntity> build() async {
    final usecase = ref.read(getSchoolUseCaseProvider);
    final res = await usecase.getSchool();

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }
}
