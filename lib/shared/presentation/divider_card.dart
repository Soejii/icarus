import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerCard extends StatelessWidget {
  const DividerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8.h,
      color: const Color.fromRGBO(37, 119, 195, 0.05),
    );
  }
}
