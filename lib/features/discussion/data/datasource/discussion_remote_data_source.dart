import 'package:dio/dio.dart';
import 'package:gaia/features/discussion/data/models/detail_discussion_model.dart';
import 'package:gaia/features/discussion/data/models/discussion_model.dart';

class DiscussionRemoteDataSource {
  final Dio _dio;
  DiscussionRemoteDataSource(this._dio);

  Future<List<DiscussionModel>> getListDiscussion(
    String type,
    int page, {
    int? idSubject,
  }) async {
    final res = await _dio.get(
      '/discuss/list/$type',
      queryParameters: {
        if (idSubject != null) 'subject_id': idSubject,
        'perPage': 20,
        'page': page
      },
    );
    final data =
        (res.data as Map<String, dynamic>)['data']['data'] as List<dynamic>;
    return data
        .map(
          (e) => DiscussionModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<DetailDiscussionModel> getDetailDiscussion(int idDiscuss) async {
    final res = await _dio.get('/discuss/detail/$idDiscuss');
    final data = DetailDiscussionModel.fromJson(res.data['data']);
    return data;
  }

  Future<void> createDiscussion(
    String type,
    String text, {
    int? subjectId,
  }) async {
    await _dio.post(
      '/discuss/post-discussion/$type',
      data: {
        if (subjectId != null) 'subject_id': subjectId,
        'text': text,
      },
    );
  }

    Future<void> createComment(
    String text,
    int discussionId, 
    ) async {
    await _dio.post(
      '/discuss/post-comment/$discussionId',
      data: {
        'text': text,
      },
    );
  }
}
