import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_history_controller.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_providers.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_card.dart';
import 'package:icarus/shared/presentation/paged.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';

class AbsenceLetterHistoryListWidget extends ConsumerWidget {
  const AbsenceLetterHistoryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(absenceLetterHistoryControllerProvider);

    return Column(
      children: [
        filterTabs(context, ref),
        Expanded(
          child: historyAsync.when(
            data: (paged) => historyList(context, ref, paged),
            error: (error, stack) => BufferErrorView(
              error: error,
              stackTrace: stack,
              onRetry: () => ref
                  .read(absenceLetterHistoryControllerProvider.notifier)
                  .refresh(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }

  filterTabs(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(absenceLetterHistoryTypeProvider);
    const filters = [
      ('all', 'Semua'),
      ('attend', 'Hadir'),
      ('not_attend', 'Tidak Hadir'),
      ('permit', 'Izin'),
    ];

    return SizedBox(
      height: 52.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final (type, label) = filters[index];
          final isSelected = selectedType == type;
          return GestureDetector(
            onTap: () => ref
                .read(absenceLetterHistoryTypeProvider.notifier)
                .state = type,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: isSelected ? context.brand.mainGradient : null,
                border: isSelected
                    ? null
                    : Border.all(color: context.brand.primary),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : context.brand.primary,
                ),
              ),
            ),
          );
        },
      ),
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
