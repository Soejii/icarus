import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gaia/features/schedule/domain/entities/schedule_entity.dart';
import 'package:gaia/features/schedule/presentation/providers/schedule_controller.dart';

class ScheduleErrorState extends ConsumerWidget {
  final DayOfWeek day;

  const ScheduleErrorState({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.w,
            color: Colors.red.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            'Gagal memuat jadwal',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Silakan coba lagi',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton.icon(
            onPressed: () {
              ref.invalidate(scheduleControllerProvider(day));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.brand.primary,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }
}
