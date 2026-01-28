import 'package:icarus/features/announcement/data/datasource/announcement_remote_data_source.dart';
import 'package:icarus/features/announcement/data/mappers/announcement_mapper.dart';
import 'package:icarus/features/announcement/domain/announcement_repository.dart';
import 'package:icarus/features/announcement/domain/entites/announcement_entity.dart';
import 'package:icarus/shared/core/types/result.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDataSource _dataSource;
  AnnouncementRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<AnnouncementEntity>>> getListAnnouncement() => guard(
        () async {
          final models = await _dataSource.getListAnnouncement();
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );
  @override
  Future<Result<AnnouncementEntity>> getDetail(int id) => guard(
        () async {
          final model = await _dataSource.getDetailAnnouncement(id);
          return model.toEntity();
        },
      );
}
