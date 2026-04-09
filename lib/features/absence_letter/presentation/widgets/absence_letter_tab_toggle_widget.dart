import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/presentation/providers/absence_letter_providers.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class AbsenceLetterTabToggleWidget extends ConsumerWidget {
  const AbsenceLetterTabToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(absenceLetterTabIndexProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: Row(
        children: [
          tabPill(
            context,
            label: 'Buat Surat Ijin',
            isSelected: selectedIndex == 0,
            onTap: () =>
                ref.read(absenceLetterTabIndexProvider.notifier).state = 0,
          ),
          SizedBox(width: 12.w),
          tabPill(
            context,
            label: 'Riwayat Surat Ijin',
            isSelected: selectedIndex == 1,
            onTap: () =>
                ref.read(absenceLetterTabIndexProvider.notifier).state = 1,
          ),
        ],
      ),
    );
  }

  tabPill(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
