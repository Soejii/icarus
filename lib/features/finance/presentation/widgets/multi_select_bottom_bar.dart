import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class MultiSelectBottomBar extends StatelessWidget {
  const MultiSelectBottomBar({
    super.key,
    required this.totalAmount,
    required this.onContinue,
  });

  final String totalAmount;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -5),
            color: Color.fromRGBO(37, 119, 195, 0.10),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Text(
            'Jumlah Total',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
          const Spacer(),
          ShaderMask(
            shaderCallback: (bounds) =>
                context.brand.mainGradient.createShader(bounds),
            child: Text(
              totalAmount,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onContinue,
            child: Container(
              height: 56.h,
              width: 120.w,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
              ),
              child: Center(
                child: Text(
                  'Lanjutkan',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
