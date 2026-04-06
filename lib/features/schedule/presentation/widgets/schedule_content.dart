import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/features/schedule/presentation/providers/schedule_controller.dart';
import 'package:icarus/features/schedule/presentation/widgets/schedule_card.dart';
import 'package:icarus/features/schedule/presentation/widgets/schedule_empty_state.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';

class ScheduleContent extends ConsumerWidget {
  const ScheduleContent({super.key, required this.day});

  final DayOfWeek day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(scheduleControllerProvider(day));
    return scheduleAsync.when(
      data: (items) {
        if (items.isEmpty) return const ScheduleEmptyState();
        return RefreshIndicator(
          onRefresh: () async =>
              ref.refresh(scheduleControllerProvider(day).future),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
            itemCount: items.length,
            itemBuilder: (_, i) => ScheduleCard(entity: items[i]),
          ),
        );
      },
      error: (error, stack) => BufferErrorView(
        error: error,
        stackTrace: stack,
        onRetry: () => ref.invalidate(scheduleControllerProvider(day)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
