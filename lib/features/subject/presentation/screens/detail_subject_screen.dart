import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/features/subject/presentation/providers/detail_subject_controller.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:gaia/features/subject/presentation/widgets/detail_subject_app_bar_skeleton.dart';
import 'package:gaia/features/subject/presentation/widgets/detail_subject_app_bar_widget.dart';
import 'package:gaia/features/subject/presentation/widgets/detail_subject_tab_bar_widget.dart';
import 'package:gaia/features/subject/presentation/widgets/discussion_content_widget.dart';
import 'package:gaia/features/subject/presentation/widgets/exam_content_widget.dart';
import 'package:gaia/features/subject/presentation/widgets/media_content_widget.dart';
import 'package:gaia/features/subject/presentation/widgets/module_content_widget.dart';
import 'package:gaia/features/subject/presentation/widgets/task_content_widget.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailSubjectScreen extends HookConsumerWidget {
  const DetailSubjectScreen(
      {super.key, required this.idSubject, this.initialTab});
  final int idSubject;
  final int? initialTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSubject = ref.watch(detailSubjectControllerProvider(idSubject));

    final tabController = useTabController(
      initialLength: 6,
      initialIndex: initialTab != null
          ? initialTab!
          : ref.watch(detailSubjectTabIndexProvider),
    );

    ref.listen(
      detailSubjectTabIndexProvider,
      (previous, next) {
        tabController.index = next;
      },
    );

    useEffect(
      () {
        if (initialTab != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(detailSubjectTabIndexProvider.notifier).set(initialTab!);
          });
        }
        return null;
      },
      [],
    );

    useEffect(
      () {
        void onChange() {
          if (!tabController.indexIsChanging) {
            ref
                .read(detailSubjectTabIndexProvider.notifier)
                .set(tabController.index);
          }
        }

        tabController.addListener(
          () => onChange(),
        );
        return () => tabController.removeListener(onChange);
      },
      [tabController],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: asyncSubject.when(
        data: (data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailSubjectAppBarWidget(entity: data),
            DetailSubjectTabBarWidget(
              tabController: tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ModuleContentWidget(idSubject: idSubject),
                  SubjectDiscussionContentWidget(idSubject: idSubject),
                  MediaContentWidget(idSubject: idSubject),
                  SubjectExamContentWidget(
                    idSubject: idSubject,
                    examType: ExamType.exam,
                  ),
                  SubjectExamContentWidget(
                    idSubject: idSubject,
                    examType: ExamType.quiz,
                  ),
                  SubjectTaskContentWidget(idSubject: idSubject),
                ],
              ),
            ),
          ],
        ),
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () =>
              ref.invalidate(detailSubjectControllerProvider(idSubject)),
        ),
        loading: () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailSubjectAppBarSkeleton(),
            DetailSubjectTabBarWidget(
              tabController: tabController,
            ),
          ],
        ),
      ),
    );
  }
}
