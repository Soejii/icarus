import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/child/presentation/providers/child_providers.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/features/schedule/presentation/widgets/schedule_child_selector.dart';
import 'package:icarus/features/schedule/presentation/widgets/schedule_content.dart';
import 'package:icarus/features/schedule/presentation/widgets/schedule_filter_tabs.dart';
import 'package:icarus/shared/core/types/failure.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ScheduleScreen extends HookConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = DayOfWeek.weekDays;
    final tabController = useTabController(initialLength: days.length);
    final childrenAsync = ref.watch(childListControllerProvider);
    final selectedChild = ref.watch(selectedChildProvider);

    // Auto-select first child when list loads and nothing is selected yet
    ref.listen(childListControllerProvider, (_, next) {
      next.whenData((children) {
        if (children.isNotEmpty && ref.read(selectedChildProvider) == null) {
          ref.read(selectedChildProvider.notifier).select(children.first);
        }
      });
    });

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Jadwal Pelajaran',
        leadingIcon: true,
      ),
      body: childrenAsync.when(
        data: (children) {
          if (children.isEmpty) {
            return BufferErrorView(
              error: UnknownFailure(
                'Tidak ada data murid',
                stackTrace: StackTrace.current,
              ),
              onRetry: () => ref.invalidate(childListControllerProvider),
            );
          }
          final studentId = selectedChild?.id ?? children.first.id;
          return Column(
            children: [
              ScheduleChildSelector(children: children),
              ScheduleFilterTabs(tabController: tabController),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: days
                      .map((day) => ScheduleContent(
                            day: day,
                            studentId: studentId,
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        },
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(childListControllerProvider),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
