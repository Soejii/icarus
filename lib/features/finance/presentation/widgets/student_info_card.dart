import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/finance/presentation/providers/home_bill_controller.dart';

class StudentInfoCard extends ConsumerWidget {
  const StudentInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBill = ref.watch(homeBillControllerProvider);
    final studentName = homeBill.valueOrNull?.studentName;
    final studentClass = homeBill.valueOrNull?.studentClass;
    final studentNis = homeBill.valueOrNull?.studentNis;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: context.brand.primary.withOpacity(0.1),
            child: Icon(
              Icons.person,
              color: context.brand.primary,
              size: 28.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homeBill.isLoading ? '-' : (studentName ?? '-'),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  homeBill.isLoading ? '-' : (studentClass ?? '-'),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  homeBill.isLoading ? '-' : 'NIS: ${studentNis ?? '-'}',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
