import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/tahfidz_tahsin_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListTahsinUsecase {
  final TahfidzTahsinRepository _repository;
  GetListTahsinUsecase(this._repository);

  Future<Result<List<TahsinRecord>>> getListTahsin({
    required int studentId,
    int page = 1,
  }) {
    return _repository.getListTahsin(studentId: studentId, page: page);
  }
}
