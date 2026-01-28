import 'package:icarus/features/edutainment/domain/entities/digital_magazine_entity.dart';
import 'package:icarus/features/edutainment/domain/entities/edutainment_entity.dart';
import 'package:icarus/features/edutainment/domain/type/edutainment_type.dart';
import 'package:icarus/shared/core/types/result.dart';

abstract class EdutainmentRepository {
  Future<Result<List<EdutainmentEntity>>> getListEdutainment(
      {required EdutainmentType type, int page = 1});
  Future<Result<EdutainmentEntity>> getDetailEdutainment({required int id});
  Future<Result<List<DigitalMagazineEntity>>> getListDigitalMagazine();
}
