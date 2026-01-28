import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';

class SchoolProfileAvatar extends StatelessWidget {
  final String photoUrl;

  const SchoolProfileAvatar({
    super.key,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 144.w,
      height: 144.h,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: context.brand.shadow,
        color: Colors.white,
      ),
      child: ClipOval(
        child: Image.network(
          photoUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.school,
              size: 72,
              color: context.brand.primary,
            );
          },
        ),
      ),
    );
  }
}
