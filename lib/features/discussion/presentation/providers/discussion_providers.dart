import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/discussion/data/datasource/discussion_remote_data_source.dart';
import 'package:gaia/features/discussion/data/discussion_repository_impl.dart';
import 'package:gaia/features/discussion/domain/discussion_repository.dart';
import 'package:gaia/features/discussion/domain/usecase/create_comment_usecase.dart';
import 'package:gaia/features/discussion/domain/usecase/get_detail_discussion_usecase.dart';
import 'package:gaia/features/discussion/domain/usecase/get_list_discussion_usecase.dart';
import 'package:gaia/features/discussion/domain/usecase/create_discussion_usecase.dart';
import 'package:gaia/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discussion_providers.g.dart';

@riverpod
DiscussionRemoteDataSource discussionRemoteDataSource(Ref ref) {
  return DiscussionRemoteDataSource(
    ref.watch(dioProvider),
  );
}

@riverpod
DiscussionRepository discussionRepository(Ref ref) {
  return DiscussionRepositoryImpl(
    ref.watch(discussionRemoteDataSourceProvider),
  );
}

@riverpod
GetListDiscussionUsecase getListDiscussionUsecase(Ref ref) {
  return GetListDiscussionUsecase(
    ref.watch(discussionRepositoryProvider),
  );
}

@riverpod
GetDetailDiscussionUsecase getDetailDiscussionUsecase(Ref ref) {
  return GetDetailDiscussionUsecase(
    ref.watch(discussionRepositoryProvider),
  );
}

@riverpod
CreateDiscussionUsecase createDiscussionUsecase(Ref ref) {
  return CreateDiscussionUsecase(
    ref.watch(discussionRepositoryProvider),
  );
}

@riverpod
CreateCommentUsecase createCommentUsecase(Ref ref) {
  return CreateCommentUsecase(
    ref.watch(discussionRepositoryProvider),
  );
}

