import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class ScheduleFilterTabs extends StatelessWidget {
  const ScheduleFilterTabs({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final days = DayOfWeek.weekDays;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.only(right: 8.w),
        tabs: days.asMap().entries.map((entry) {
          return Tab(
            height: 22.h,
            child: AnimatedBuilder(
              animation: tabController,
              builder: (context, _) {
                final isSelected = tabController.index == entry.key;
                return isSelected
                    ? selectedPill(context, entry.value.displayName)
                    : unselectedPill(context, entry.value.displayName);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  selectedPill(BuildContext context, String label) {
    return Container(
      width: 51.w,
      height: 22.h,
      decoration: BoxDecoration(
        gradient: context.brand.mainGradient,
        borderRadius: BorderRadius.circular(11.r),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  unselectedPill(BuildContext context, String label) {
    return Container(
      width: 51.w,
      height: 22.h,
      decoration: BoxDecoration(
        gradient: context.brand.mainGradient,
        borderRadius: BorderRadius.circular(11.r),
      ),
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: GradientText(
          label,
          gradient: context.brand.mainGradient,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
