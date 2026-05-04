import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class RaporEmptyState extends StatelessWidget {
  const RaporEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: 48.r,
                color: context.brand.inactive,
              ),
              SizedBox(height: 12.h),
              Text(
                'Belum ada rapor untuk anak ini.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
