import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:go_router/go_router.dart';

class QuickHomeButton extends StatelessWidget {
  const QuickHomeButton({
    super.key,
    required this.path,
    required this.label,
    required this.icon,
  });
  final String path;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(path);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(210, 239, 255, 1),
                  Color.fromRGBO(255, 255, 255, 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Image.asset(icon),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textSecondary,
          ),
        )
      ],
    );
  }
}
