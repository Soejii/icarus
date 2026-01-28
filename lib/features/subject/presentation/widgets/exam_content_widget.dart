import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/features/activity/presentation/widgets/exam_card.dart';
import 'package:gaia/features/activity/presentation/widgets/quiz_card.dart';
import 'package:gaia/features/subject/presentation/providers/exam_subject_controller.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubjectExamContentWidget extends HookConsumerWidget {
  const SubjectExamContentWidget({
    super.key,
    required this.idSubject,
    required this.examType,
  });
  final int idSubject;
  final ExamType examType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncExam =
        ref.watch(examSubjectControllerProvider(idSubject, examType));
    final provider =
        ref.read(examSubjectControllerProvider(idSubject, examType).notifier);

    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.loadMore();
        }
      }

      scrollController.addListener(
        () => onScroll(),
      );
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return asyncExam.when(
      data: (data) {
        if (data.items.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () => ref
                .read(
                    examSubjectControllerProvider(idSubject, examType).notifier)
                .refresh(),
            child: ListView.separated(
              controller: scrollController,
              itemCount: data.items.length + (data.isMoreLoading ? 1 : 0),
              itemBuilder: (context, i) {
                if (i >= data.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final item = data.items[i];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: examType == ExamType.exam
                      ? ExamCard(entity: item)
                      : QuizCard(entity: item),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
            ),
          );
        } else {
          return DataNotFoundScreen(dataType: examType.name);
        }
      },
      error: (error, stackTrace) => BufferErrorView(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(examSubjectControllerProvider(idSubject, examType)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
