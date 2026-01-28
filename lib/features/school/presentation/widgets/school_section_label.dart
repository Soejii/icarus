import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';

class SchoolSectionLabel extends StatelessWidget {
  final String label;

  const SchoolSectionLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: context.brand.textSecondary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
