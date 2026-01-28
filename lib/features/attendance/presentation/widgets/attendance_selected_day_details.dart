import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/features/attendance/domain/type/attendance_status_extension.dart';
import 'package:intl/intl.dart';

class AttendanceSelectedDayDetails extends StatelessWidget {
  final DateTime? selectedDay;
  final Map<DateTime, AttendanceEntity> attendanceMap;

  const AttendanceSelectedDayDetails({
    super.key,
    required this.selectedDay,
    required this.attendanceMap,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedDay == null) return const SizedBox.shrink();

    final attendanceEntity = attendanceMap[
        DateTime(selectedDay!.year, selectedDay!.month, selectedDay!.day)];
    final dayName = DateFormat('EEEE', 'id_ID').format(selectedDay!);
    final fullDate = DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDay!);

    String statusDisplay = '-';

    if (attendanceEntity != null) {
      if (attendanceEntity.checkedInTime != null ||
          attendanceEntity.checkedOutTime != null) {
        statusDisplay = 'Hadir';
      } else {
        statusDisplay = attendanceEntity.status.displayName;
      }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Hari/Tanggal: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                ),
              ),
              Text(
                '$dayName, $fullDate',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: context.brand.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                'Status: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                ),
              ),
              Text(
                statusDisplay,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: context.brand.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keterangan: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                ),
              ),
              Expanded(
                child: Text(
                  attendanceEntity?.notes ?? '-',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.brand.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
