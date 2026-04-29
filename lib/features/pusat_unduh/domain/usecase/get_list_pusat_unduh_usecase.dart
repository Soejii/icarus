import 'package:icarus/features/pusat_unduh/domain/entities/pusat_unduh_entity.dart';
import 'package:icarus/features/pusat_unduh/domain/pusat_unduh_repository.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListPusatUnduhUsecase {
  final PusatUnduhRepository _repository;
  GetListPusatUnduhUsecase(this._repository);

  Future<Result<List<PusatUnduhEntity>>> execute({int page = 1}) {
    return _repository.getListPusatUnduh(page: page);
  }
}
