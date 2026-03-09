import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PerformanceCardSkeleton extends StatelessWidget {
  const PerformanceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
