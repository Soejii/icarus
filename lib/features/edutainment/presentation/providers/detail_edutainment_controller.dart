import 'package:gaia/features/edutainment/domain/entities/edutainment_entity.dart';
import 'package:gaia/features/edutainment/presentation/providers/edutainment_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_edutainment_controller.g.dart';

@riverpod
class DetailEdutainmentController extends _$DetailEdutainmentController {
    @override
  Future<EdutainmentEntity> build(int id) async {
    final usecase = ref.read(getDetailEdutainmentUsecaseProvider);
    final res = await usecase.getDetail(id);

    return res.fold(
      (failure) => throw failure,
      (entity) => entity,
    );
  }
}