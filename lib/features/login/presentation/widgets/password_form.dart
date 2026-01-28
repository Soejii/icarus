import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class PasswordForm extends HookWidget {
  final TextEditingController controller;

  const PasswordForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isObscure = useState(true);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 0, 0.10),
                width: 1.w,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48.h,
                  width: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 0.10),
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.lock,
                      color: context.brand.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    obscureText: isObscure.value,
                    controller: controller,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '********',
                      hintStyle: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.inactive,
                        fontStyle: FontStyle.italic,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isObscure.value = !isObscure.value;
                        },
                        icon: Icon(
                          isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: context.brand.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
