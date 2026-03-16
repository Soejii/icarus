import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';

class SuccessStatusWidget extends StatelessWidget {
  const SuccessStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AssetsHelper.imgSuccess,
          width: 100.w,
          height: 100.w,
        ),
        SizedBox(height: 16.h),
        Text(
          'Transaksi Berhasil',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.brand.textMain,
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            'Pembayaran Anda telah berhasil diproses.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
