import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/types/failure.dart';
import 'package:go_router/go_router.dart';

class UnknownErrorScreen extends StatelessWidget {
  const UnknownErrorScreen({super.key, required this.error});
  final Failure error;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 120.h),
          SizedBox(
            height: 260.h,
            width: 280.w,
            child: Image.asset(
              AssetsHelper.imgNetworkError,
            ),
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Tenang! Bukan Salah Kamu',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: context.brand.textMain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Yuk Kembali Ke Halaman Sebelumnya!',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: context.brand.textMain,
              ),
            ),
          ),
          // SizedBox(height: 20.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w),
          //   child: Text(
          //     '${error.stackTrace},  ${error.toString()}',
          //     style: TextStyle(
          //       fontSize: 12.sp,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w600,
          //       color: context.brand.textMain,
          //     ),
          //   ),
          // ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                height: 40.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.brand.primary,
                  boxShadow: context.brand.shadow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
