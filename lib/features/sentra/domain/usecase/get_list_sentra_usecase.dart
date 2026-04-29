import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/features/sentra/domain/sentra_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListSentraUsecase {
  final SentraRepository _repository;
  GetListSentraUsecase(this._repository);

  Future<Result<List<SentraEntity>>> execute({
    required int studentId,
    int page = 1,
  }) {
    return _repository.getListSentra(studentId: studentId, page: page);
  }
}
