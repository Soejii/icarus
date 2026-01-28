import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:go_router/go_router.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({super.key, required this.label, required this.path});
  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(path);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          width: double.infinity,
          decoration: BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                color: context.brand.inactive,
                width: 1,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
