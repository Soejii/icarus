import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/tahfidz_tahsin_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListTahfidzUsecase {
  final TahfidzTahsinRepository _repository;
  GetListTahfidzUsecase(this._repository);

  Future<Result<List<TahfidzRecord>>> execute({
    required int studentId,
    int page = 1,
  }) {
    return _repository.getListTahfidz(studentId: studentId, page: page);
  }
}
