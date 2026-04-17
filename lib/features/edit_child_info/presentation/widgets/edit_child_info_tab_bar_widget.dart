import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_child_info/presentation/providers/edit_child_info_providers.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class EditChildInfoTabBarWidget extends ConsumerWidget {
  const EditChildInfoTabBarWidget({super.key, required this.tabController});

  final TabController tabController;

  static const _tabs = [
    'Data Pribadi',
    'Data Alamat',
    'Informasi Tambahan',
    'Dokumen',
    'Informasi Sekolah & Program',
    'Informasi Bank',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: List.generate(
          _tabs.length,
          (i) => tabPill(context, ref, i, _tabs[i]),
        ),
      ),
    );
  }

  tabPill(BuildContext context, WidgetRef ref, int index, String label) {
    final isSelected = ref.watch(editChildInfoTabIndexProvider) == index;
    return GestureDetector(
      onTap: () =>
          ref.read(editChildInfoTabIndexProvider.notifier).set(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: isSelected ? context.brand.mainGradient : null,
          border: isSelected
              ? null
              : Border.all(color: context.brand.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: isSelected
            ? Text(
                label,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
            : GradientText(
                label,
                gradient: context.brand.mainGradient,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
