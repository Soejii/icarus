import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/task/presentation/widgets/task_card.dart';
import 'package:gaia/features/subject/presentation/providers/task_subject_controller.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubjectTaskContentWidget extends HookConsumerWidget {
  const SubjectTaskContentWidget({super.key, required this.idSubject});
  final int idSubject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTask = ref.watch(taskSubjectControllerProvider(idSubject));
    final provider =
        ref.read(taskSubjectControllerProvider(idSubject).notifier);

    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          provider.loadMore(idSubject);
        }
      }

      scrollController.addListener(
        () => onScroll(),
      );
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return asyncTask.when(
      data: (data) {
        if (data.items.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () => ref
                .read(taskSubjectControllerProvider(idSubject).notifier)
                .refresh(idSubject),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 12.h),
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
                  child: TaskCard(entity: item),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
            ),
          );
        } else {
          return const DataNotFoundScreen(dataType: 'Tugas');
        }
      },
      error: (error, stackTrace) => BufferErrorView(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(taskSubjectControllerProvider(idSubject)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
