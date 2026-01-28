import 'package:gaia/features/discussion/presentation/providers/detail_discussion_controller.dart';
import 'package:gaia/features/discussion/presentation/providers/discussion_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gaia/shared/core/types/result.dart';

part 'create_comment_controller.g.dart';

@riverpod
class CreateCommentController extends _$CreateCommentController {
  @override
  Future<void> build() async {}

  Future<Result<Unit>> createComment(String text, int discussionId) async {
    state = const AsyncLoading();

    late final Result<Unit> result;

    final usecase = ref.read(createCommentUsecaseProvider);
    result = await usecase.createComment(text, discussionId);
    ref.read(detailDiscussionControllerProvider(discussionId).notifier).refresh();

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
    return result;
  }
}
