import 'package:icarus/features/edutainment/domain/edutainment_repository.dart';
import 'package:icarus/features/edutainment/domain/entities/edutainment_entity.dart';
import 'package:icarus/features/edutainment/domain/type/edutainment_type.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListEdutainmentUsecase {
  final EdutainmentRepository _repository;
  GetListEdutainmentUsecase(this._repository);

  Future<Result<List<EdutainmentEntity>>> getListEdutainment(
      {required EdutainmentType type, int page = 1}) async {
    return await _repository.getListEdutainment(type: type,page: page);
  }
}
