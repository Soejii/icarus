import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import '../../domain/entities/schedule_entity.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleEntity schedule;

  const ScheduleCard({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: context.brand.primary,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: context.brand.shadow,
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            margin: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFC9EEFF),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: context.brand.shadow,
            ),
            child: schedule.subjectImage.isNotEmpty
                ? Container(
                    padding: EdgeInsets.all(8.r),
                    child: Image.asset(
                      schedule.subjectImage,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.book,
                          color: context.brand.primary,
                          size: 32.sp,
                        );
                      },
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(8.r),
                    child: Icon(
                      Icons.book,
                      color: context.brand.primary,
                      size: 32.sp,
                    ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 16.r, top: 16.r, bottom: 16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule.subjectName,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    schedule.teacherName,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${schedule.startTime}-${schedule.endTime} WIB',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
