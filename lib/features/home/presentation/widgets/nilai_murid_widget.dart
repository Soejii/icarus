import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/performance/presentation/providers/performance_exam_controller.dart';
import 'package:icarus/features/performance/presentation/providers/performance_providers.dart';
import 'package:icarus/features/performance/presentation/widgets/performance_card.dart';
import 'package:icarus/features/performance/presentation/widgets/performance_card_error.dart';
import 'package:icarus/features/performance/presentation/widgets/performance_card_skeleton.dart';
import 'package:icarus/shared/core/domain/types/exam_type.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class NilaiMuridWidget extends ConsumerWidget {
  const NilaiMuridWidget({super.key, required this.type});
  final ExamType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examAsync = ref.watch(
      performanceExamControllerProvider(type),
    );
    return examAsync.when(
      data: (data) => data.items.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Nilai ${type.realName} Murid',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: context.brand.textMain,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(performanceTabIndexProvider.notifier).set(2);
                          context.goNamed(RouteName.performance);
                        },
                        child: GradientText(
                          'Lihat Semua',
                          gradient: context.brand.mainGradient,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PerformanceCard(
                  entity: data.items[0],
                  type: type,
                ),
                if (data.items.length >= 2)
                  PerformanceCard(
                    entity: data.items[1],
                    type: type,
                  ),
                SizedBox(height: 16.h),
              ],
            )
          : const SizedBox.shrink(),
      error: (e, _) => PerformanceCardError(
        error: e,
        onRetry: () => ref.invalidate(performanceExamControllerProvider),
      ),
      loading: () => const PerformanceCardSkeleton(),
    );
  }
}
