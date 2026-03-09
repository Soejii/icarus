import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/performance/domain/types/performance_type.dart';
import 'package:icarus/features/performance/presentation/providers/performance_exam_controller.dart';
import 'package:icarus/features/performance/presentation/widgets/performance_card.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';

class PerformanceContentWidget extends HookConsumerWidget {
  const PerformanceContentWidget({super.key, required this.type});
  final PerformanceType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPerformanceExam =
        ref.watch(performanceExamControllerProvider(type.changeToExamType));
    final provider = ref.read(
        performanceExamControllerProvider(type.changeToExamType).notifier);

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

    return asyncPerformanceExam.when(
      data: (data) {
        if (data.items.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () => ref
                .read(performanceExamControllerProvider(type.changeToExamType)
                    .notifier)
                .refresh(),
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
                return PerformanceCard(
                  entity: item,
                  type: type.changeToExamType,
                );
              },
            ),
          );
        } else {
          return const DataNotFoundScreen(dataType: 'Aktifitas');
        }
      },
      error: (error, stackTrace) => BufferErrorView(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(
            performanceExamControllerProvider(type.changeToExamType)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
