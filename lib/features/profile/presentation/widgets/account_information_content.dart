import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class AccountInfoItem {
  final String label;
  final String value;

  const AccountInfoItem({
    required this.label,
    required this.value,
  });
}

class AccountInfoField extends StatelessWidget {
  final AccountInfoItem item;

  const AccountInfoField({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: TextStyle(
              color: context.brand.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: context.brand.shadow,
            ),
            padding: EdgeInsets.all(20.w),
            child: Text(
              item.value,
              style: TextStyle(
                color: context.brand.textMain,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
