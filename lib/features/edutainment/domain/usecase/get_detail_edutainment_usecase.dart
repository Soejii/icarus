import 'package:icarus/features/edutainment/domain/edutainment_repository.dart';
import 'package:icarus/features/edutainment/domain/entities/edutainment_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetDetailEdutainmentUsecase {
  final EdutainmentRepository _repository;
  GetDetailEdutainmentUsecase(this._repository);

  Future<Result<EdutainmentEntity>> getDetail (int id){
    return _repository.getDetailEdutainment(id: id);
  }
}
