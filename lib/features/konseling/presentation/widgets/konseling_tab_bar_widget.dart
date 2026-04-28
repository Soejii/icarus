import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:icarus/features/konseling/presentation/providers/konseling_controller.dart';

class KonselingTabBarWidget extends ConsumerWidget {
  const KonselingTabBarWidget({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(konselingTabIndexProvider);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: konselingTypes.asMap().entries.map((entry) {
          final isSelected = currentIndex == entry.key;
          return GestureDetector(
            onTap: () {
              ref.read(konselingTabIndexProvider.notifier).set(entry.key);
              tabController.animateTo(entry.key);
            },
            child: isSelected
                ? selectedPill(context, entry.value.displayName)
                : unselectedPill(context, entry.value.displayName),
          );
        }).toList(),
      ),
    );
  }

  selectedPill(BuildContext context, String label) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: context.brand.green,
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  unselectedPill(BuildContext context, String label) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: context.brand.green, width: 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: context.brand.green,
        ),
      ),
    );
  }
}
