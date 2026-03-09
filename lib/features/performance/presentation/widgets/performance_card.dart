import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/domain/entities/exam_entity.dart';
import 'package:icarus/shared/core/domain/types/exam_type.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({super.key, required this.entity, required this.type});
  final ExamEntity entity;
  final ExamType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color.fromRGBO(0, 0, 0, 0.10),
            width: 1.w,
          ),
          bottom: BorderSide(
            color: const Color.fromRGBO(0, 0, 0, 0.10),
            width: 1.w,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 32.w,
              height: 32.h,
              child: Image.asset(type.asset),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    entity.subjectName ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.textMain,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    entity.title ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    entity.teacherName ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.textMain,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 18.w),
            Text(
              (entity.score ?? 0).toString(),
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: context.brand.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
