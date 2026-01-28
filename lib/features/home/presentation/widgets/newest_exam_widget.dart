import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/core/domain/types/exam_type.dart';
import 'package:gaia/features/activity/presentation/providers/activity_providers.dart';
import 'package:gaia/features/activity/presentation/providers/exam_controller.dart';
import 'package:gaia/features/activity/presentation/widgets/exam_card.dart';
import 'package:gaia/features/activity/presentation/widgets/exam_error_card.dart';
import 'package:gaia/features/activity/presentation/widgets/exam_skeleton_card.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewestExamWidget extends ConsumerWidget {
  const NewestExamWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examAsync = ref.watch(examControllerProvider(ExamType.exam));
    return examAsync.when(
      data: (data) => data.items.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latihan Soal Tebaru',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: context.brand.textMain,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(activityTabIndexProvider.notifier).set(0);
                          context.goNamed('activity');
                        },
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: context.brand.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ExamCard(entity: data.items[0])
                ],
              ),
            )
          : const SizedBox.shrink(),
      error: (e, _) => ExamErrorCard(
        error: e,
        onRetry: () => ref.invalidate(examControllerProvider),
      ),
      loading: () => const ExamSkeletonCard(),
    );
  }
}
