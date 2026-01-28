import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/features/attendance/domain/type/attendance_status.dart';
import 'package:gaia/features/attendance/domain/type/attendance_status_extension.dart';

class AttendanceCalendarDay extends StatelessWidget {
  final DateTime day;
  final AttendanceEntity? attendanceEntity;
  final bool isToday;

  const AttendanceCalendarDay({
    super.key,
    required this.day,
    required this.attendanceEntity,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Gradient? gradient;

    if (isToday) {
      gradient = const LinearGradient(
        colors: [Color(0xFF3229A0), Color(0xFF832AA3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (attendanceEntity != null) {
      if (attendanceEntity!.checkedInTime != null || 
          attendanceEntity!.checkedOutTime != null) {
        backgroundColor = AttendanceStatus.checkedOut.color;
      } else {
        backgroundColor = attendanceEntity!.status.color;
      }
    }

    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: (isToday || attendanceEntity != null)
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}