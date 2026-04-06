import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';

class ScheduleEmptyState extends StatelessWidget {
  const ScheduleEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AssetsHelper.imgTidakAdaPelajaran, width: 240.w),
          SizedBox(height: 16.h),
          Text(
            'Yeay...',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Hari ini murid bisa belajar di rumah',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
