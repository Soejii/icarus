import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/features/attendance/domain/type/attendance_status.dart';
import 'package:gaia/features/attendance/domain/type/attendance_status_extension.dart';
import 'package:gaia/features/attendance/presentation/providers/attedance_controller.dart';
import 'package:intl/intl.dart';

class AttendanceHistoryWidget extends ConsumerWidget {
  const AttendanceHistoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceControllerProvider);

    return attendanceAsync.when(
      data: (attendanceList) {
        if (attendanceList.isEmpty) {
          return const Center(
            child: Text('Tidak ada data kehadiran'),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.separated(
            itemCount: attendanceList.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final attendance = attendanceList[index];
              return AttendanceHistoryCard(attendance: attendance);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => BufferErrorView(
        error: error,
        stackTrace: stack,
        onRetry: () => ref.invalidate(attendanceControllerProvider),
      ),
    );
  }
}

class AttendanceHistoryCard extends StatelessWidget {
  final AttendanceEntity attendance;

  const AttendanceHistoryCard({
    super.key,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAttendanceInfo(context),
          SizedBox(height: 8.h),
          Text(
            _formatDate(attendance.date),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceInfo(BuildContext context) {
    if (attendance.checkedInTime != null && attendance.checkedOutTime != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAttendanceRow(
            'Absen Masuk',
            attendance.checkedInTime!,
            AttendanceStatus.checkedIn.color,
            context,
          ),
          SizedBox(height: 4.h),
          _buildAttendanceRow(
            'Absen Pulang',
            attendance.checkedOutTime!,
            AttendanceStatus.checkedOut.color,
            context,
          ),
        ],
      );
    } else if (attendance.checkedInTime != null) {
      return _buildAttendanceRow(
        'Absen Masuk',
        attendance.checkedInTime!,
        AttendanceStatus.checkedIn.color,
        context,
      );
    } else if (attendance.checkedOutTime != null) {
      return _buildAttendanceRow(
        'Absen Pulang',
        attendance.checkedOutTime!,
        AttendanceStatus.checkedOut.color,
        context,
      );
    } else {
      return Text(
        attendance.status.displayName,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: attendance.status.color,
        ),
      );
    }
  }

  Widget _buildAttendanceRow(
      String label, String time, Color labelColor, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: labelColor,
            ),
          ),
        ),
        Text(
          _formatTime(time),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.brand.textSecondary,
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('EEEE, dd MMM yyyy', 'id_ID').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String _formatTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }
}
