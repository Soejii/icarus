import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_history_controller.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_card.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';

class AbsenceLetterHistoryListWidget extends ConsumerWidget {
  const AbsenceLetterHistoryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(absenceLetterHistoryControllerProvider);

    return historyAsync.when(
      data: (paged) => historyList(context, ref, paged),
      error: (error, stack) => BufferErrorView(
        error: error,
        stackTrace: stack,
        onRetry: () =>
            ref.read(absenceLetterHistoryControllerProvider.notifier).refresh(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  historyList(
    BuildContext context,
    WidgetRef ref,
    Paged<AbsenceLetterEntity> paged,
  ) {
    if (paged.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: () =>
            ref.read(absenceLetterHistoryControllerProvider.notifier).refresh(),
        child: ListView(
          children: [
            SizedBox(height: 180.h),
            Center(
              child: Text(
                'Belum ada surat izin.',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  color: context.brand.textSecondary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 120.h) {
          ref.read(absenceLetterHistoryControllerProvider.notifier).loadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(absenceLetterHistoryControllerProvider.notifier).refresh(),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
          itemCount: paged.items.length + (paged.isMoreLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= paged.items.length) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            return AbsenceLetterCard(entity: paged.items[index]);
          },
        ),
      ),
    );
  }
}
