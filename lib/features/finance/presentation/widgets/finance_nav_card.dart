import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:go_router/go_router.dart';

class FinanceNavCard extends StatelessWidget {
  const FinanceNavCard({
    super.key,
    required this.icon,
    required this.title,
    required this.routeName,
  });

  final String icon;
  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(routeName),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: context.brand.shadow,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 28.w,
              height: 28.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.brand.textSecondary,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}
