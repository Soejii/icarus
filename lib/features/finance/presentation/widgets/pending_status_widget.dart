import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class PendingStatusWidget extends StatelessWidget {
  const PendingStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9800).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.hourglass_bottom,
            color: const Color(0xFFFF9800),
            size: 40.w,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Menunggu Konfirmasi',
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
            'Pembayaran Anda sedang diproses. Silakan tunggu konfirmasi dari pihak sekolah.',
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
