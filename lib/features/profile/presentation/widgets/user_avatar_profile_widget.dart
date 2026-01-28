import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';

class UserAvatarProfileWidget extends StatelessWidget {
  const UserAvatarProfileWidget({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.className,
  });
  final String imgUrl;
  final String name;
  final String className;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 144.h,
          height: 144.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 3.w,
              color: context.brand.primary,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(144),
            child: Image.network(
              imgUrl,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                AssetsHelper.imgProfilePlaceholder,
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200.h,
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: context.brand.textMain,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Kelas: $className',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
