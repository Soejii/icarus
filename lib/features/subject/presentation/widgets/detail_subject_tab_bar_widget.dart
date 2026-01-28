import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/presentation/providers/subject_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailSubjectTabBarWidget extends ConsumerWidget {
  const DetailSubjectTabBarWidget({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainIndex = ref.watch(detailSubjectTabIndexProvider);

    final listTabBar = [
      'Modul',
      'Diskusi',
      'Media',
      'Latihan Soal',
      'Quiz',
      'Tugas',
    ];

    return Container(
        height: 56.h,
        width: double.infinity,
        decoration:  BoxDecoration(
          color: Colors.white,
          boxShadow: context.brand.shadow,
        ),
        child: TabBar(
          onTap: (value) =>
              ref.read(detailSubjectTabIndexProvider.notifier).set(value),
          controller: tabController,
          indicator: const BoxDecoration(color: Colors.transparent),
          isScrollable: true,
          tabs: listTabBar.asMap().entries.map(
            (e) {
              final index = e.key;
              final label = e.value;
              final isSelected = mainIndex == index;
              return Tab(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 28.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: isSelected ? context.brand.primary : Colors.white,
                    border: Border.all(
                      width: 1.w,
                      color: isSelected
                          ? Colors.transparent
                          : context.brand.primary,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : context.brand.inactive,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ));
  }
}
