import 'package:gaia/features/discussion/data/datasource/discussion_remote_data_source.dart';
import 'package:gaia/features/discussion/data/mappers/detail_discussion_mapper.dart';
import 'package:gaia/features/discussion/data/mappers/discussion_mapper.dart';
import 'package:gaia/features/discussion/domain/discussion_repository.dart';
import 'package:gaia/features/discussion/domain/entity/detail_discussion_entity.dart';
import 'package:gaia/features/discussion/domain/entity/discussion_entity.dart';
import 'package:gaia/shared/core/types/result.dart';

class DiscussionRepositoryImpl implements DiscussionRepository {
  final DiscussionRemoteDataSource _dataSource;
  DiscussionRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<DiscussionEntity>>> getListDiscussion(
    String type,
    int page, {
    int? idSubject,
  }) =>
      guard(
        () async {
          final models = await _dataSource.getListDiscussion(type, page,
              idSubject: idSubject);
          return models
              .map(
                (model) => model.toEntity(),
              )
              .toList();
        },
      );

  @override
  Future<Result<DetailDiscussionEntity>> getDetailDiscussion(int idDiscuss) =>
      guard(
        () async {
          final models = await _dataSource.getDetailDiscussion(idDiscuss);
          return models.toEntity();
        },
      );

  @override
  Future<Result<Unit>> createDiscussion(String type, String text,
          {int? subjectId}) =>
      guard(
        () async {
          await _dataSource.createDiscussion(type, text, subjectId: subjectId);
          return const Unit();
        },
      );

  @override
  Future<Result<Unit>> createComment(String text, int discussionId) => guard(
        () async {
          await _dataSource.createComment(text, discussionId);
          return const Unit();
        },
      );
}
