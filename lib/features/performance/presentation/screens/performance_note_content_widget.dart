import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/performance/domain/types/daily_note_type.dart';
import 'package:icarus/features/performance/presentation/providers/performance_class_note_controller.dart';
import 'package:icarus/features/performance/presentation/providers/performance_student_note_controller.dart';
import 'package:icarus/features/performance/presentation/widgets/daily_note_card.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';

class PerformanceNoteContentWidget extends HookConsumerWidget {
  const PerformanceNoteContentWidget({super.key, required this.kind});

  final DailyNoteType kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotes = kind == DailyNoteType.student
        ? ref.watch(performanceStudentNoteControllerProvider)
        : ref.watch(performanceClassNoteControllerProvider);

    final scrollController = useScrollController();

    useEffect(
      () {
        void onScroll() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            loadMore(ref);
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    return asyncNotes.when(
      data: (data) {
        if (data.items.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () => refresh(ref),
            child: ListView.builder(
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
                return DailyNoteCard(
                  entity: item,
                  kind: kind,
                  onTap: () {
                    final routeName = kind == DailyNoteType.student
                        ? RouteName.studentDailyNoteDetail
                        : RouteName.classDailyNoteDetail;
                    context.pushNamed(
                      routeName,
                      pathParameters: {'id': item.id.toString()},
                    );
                  },
                );
              },
            ),
          );
        }

        return const DataNotFoundScreen(dataType: 'Catatan');
      },
      error: (error, stackTrace) {
        if (kind == DailyNoteType.student) {
          return BufferErrorView(
            error: error,
            stackTrace: stackTrace,
            onRetry: () =>
                ref.invalidate(performanceStudentNoteControllerProvider),
          );
        }

        return BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () =>
              ref.invalidate(performanceClassNoteControllerProvider),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> refresh(WidgetRef ref) {
    if (kind == DailyNoteType.student) {
      return ref.read(performanceStudentNoteControllerProvider.notifier).refresh();
    }

    return ref.read(performanceClassNoteControllerProvider.notifier).refresh();
  }

  Future<void> loadMore(WidgetRef ref) {
    if (kind == DailyNoteType.student) {
      return ref.read(performanceStudentNoteControllerProvider.notifier).loadMore();
    }

    return ref.read(performanceClassNoteControllerProvider.notifier).loadMore();
  }
}
