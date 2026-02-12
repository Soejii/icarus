import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/performance/domain/types/performance_type.dart';
import 'package:icarus/features/performance/presentation/providers/performance_providers.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class PerformanceTabBarWidget extends ConsumerWidget {
  const PerformanceTabBarWidget({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainIndex = ref.watch(performanceTabIndexProvider);
    return Container(
      height: 56.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        onTap: (value) =>
            ref.read(performanceTabIndexProvider.notifier).set(value),
        tabs: performanceTypes.asMap().entries.map(
          (e) {
            final isSelected = mainIndex == e.value.index;
            return GradientText(
              e.value.name,
              gradient: isSelected
                  ? context.brand.mainGradient
                  : LinearGradient(
                      colors: [
                        context.brand.textSecondary,
                        context.brand.textSecondary,
                      ],
                    ),
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
