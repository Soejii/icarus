import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class FinanceBalanceCard extends StatelessWidget {
  const FinanceBalanceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
  });

  final String icon;
  final String label;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: context.brand.shadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              amount,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
