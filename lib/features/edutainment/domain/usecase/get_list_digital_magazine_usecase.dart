import 'package:icarus/features/edutainment/domain/edutainment_repository.dart';
import 'package:icarus/features/edutainment/domain/entities/digital_magazine_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class GetListDigitalMagazineUsecase {
  final EdutainmentRepository _repository;
  GetListDigitalMagazineUsecase(this._repository);

  Future<Result<List<DigitalMagazineEntity>>> getListDigitalMagazine() {
    return _repository.getListDigitalMagazine();
  }
}
