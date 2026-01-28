import 'package:gaia/features/discussion/presentation/providers/discussion_class_controller.dart';
import 'package:gaia/features/discussion/presentation/providers/discussion_providers.dart';
import 'package:gaia/features/discussion/presentation/types/create_discussion_type.dart';
import 'package:gaia/features/subject/presentation/providers/discussion_subject_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gaia/features/discussion/presentation/types/create_discussion_args.dart';
import 'package:gaia/shared/core/types/result.dart';

part 'create_discussion_controller.g.dart';

@riverpod
class CreateDiscussionController extends _$CreateDiscussionController {
  @override
  Future<void> build() async {}

  Future<Result<Unit>> createDiscussion(
    CreateDiscussionArgs args,
    String text,
  ) async {
    state = const AsyncLoading();

    late final Result<Unit> result;

    if (args.type == CreateDiscussionType.kelas) {
      final usecase = ref.read(createDiscussionUsecaseProvider);
      result = await usecase.createDiscussion('class', text);
      ref.read(discussionClassControllerProvider.notifier).refresh();
    } else {
      final usecase = ref.read(createDiscussionUsecaseProvider);
      result = await usecase.createDiscussion('subject', text,
          subjectId: args.subjectId);
      ref
          .read(discussionSubjectControllerProvider(args.subjectId!).notifier)
          .refresh();
    }

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
    return result;
  }
}
