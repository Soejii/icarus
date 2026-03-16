import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';

class NoBillWidget extends StatelessWidget {
  const NoBillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            AssetsHelper.imgDataNotFound,
            width: 159.w,
            height: 159.w,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Belum Ada tagihan baru',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Terima Kasih anda telah membayar semua\ntagihan dengan tepat waktu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textSecondary,
          ),
        ),
      ],
    );
  }
}
