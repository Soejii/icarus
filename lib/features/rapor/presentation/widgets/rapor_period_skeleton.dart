import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class RaporPeriodSkeleton extends StatelessWidget {
  const RaporPeriodSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final placeholderColor = context.brand.inactive.withOpacity(0.2);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: placeholderColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 140.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: placeholderColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          width: 80.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: placeholderColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
