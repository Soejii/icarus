import 'package:gaia/features/edutainment/domain/edutainment_repository.dart';
import 'package:gaia/features/edutainment/domain/entities/digital_magazine_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class GetListDigitalMagazineUsecase {
  final EdutainmentRepository _repository;
  GetListDigitalMagazineUsecase(this._repository);

  Future<Result<List<DigitalMagazineEntity>>> getListDigitalMagazine() {
    return _repository.getListDigitalMagazine();
  }
}
