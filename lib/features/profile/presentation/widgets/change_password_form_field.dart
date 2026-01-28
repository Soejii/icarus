import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class ChangePasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const ChangePasswordFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            obscuringCharacter: '*',
            validator: validator,
            style: TextStyle(
              color: context.brand.textMain,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: context.brand.inactive,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.all(20.w),
            ),
          ),
        ),
      ],
    );
  }
}
