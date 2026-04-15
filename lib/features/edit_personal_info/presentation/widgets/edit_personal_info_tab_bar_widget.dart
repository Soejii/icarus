import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/presentation/providers/edit_personal_info_providers.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class EditPersonalInfoTabBarWidget extends ConsumerWidget {
  const EditPersonalInfoTabBarWidget({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              tabPill(context, ref, 0, 'Notifikasi WA'),
              SizedBox(width: 12.w),
              tabPill(context, ref, 1, 'Ayah'),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              tabPill(context, ref, 2, 'Ibu'),
              SizedBox(width: 12.w),
              tabPill(context, ref, 3, 'Wali'),
            ],
          ),
        ],
      ),
    );
  }

  tabPill(BuildContext context, WidgetRef ref, int index, String label) {
    final isSelected =
        ref.watch(editPersonalInfoTabIndexProvider) == index;
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            ref.read(editPersonalInfoTabIndexProvider.notifier).set(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            gradient: isSelected ? context.brand.mainGradient : null,
            border: isSelected
                ? null
                : Border.all(color: context.brand.primary),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
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
        ),
      ),
    );
  }
}
