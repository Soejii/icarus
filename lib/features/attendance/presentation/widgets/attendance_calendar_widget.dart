import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/features/attendance/presentation/providers/attedance_controller.dart';
import 'package:gaia/features/attendance/presentation/widgets/attendance_calendar_table.dart';
import 'package:gaia/features/attendance/presentation/widgets/attendance_calendar_legend.dart';
import 'package:gaia/features/attendance/presentation/widgets/attendance_selected_day_details.dart';

class AttendanceCalendarWidget extends ConsumerStatefulWidget {
  const AttendanceCalendarWidget({super.key});

  @override
  ConsumerState<AttendanceCalendarWidget> createState() =>
      _AttendanceCalendarWidgetState();
}

class _AttendanceCalendarWidgetState
    extends ConsumerState<AttendanceCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final attendanceAsync = ref.watch(attendanceControllerProvider);

    return attendanceAsync.when(
      data: (attendanceList) {
        final attendanceMap = _createAttendanceMap(attendanceList);

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AttendanceCalendarTable(
                attendanceMap: attendanceMap,
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              SizedBox(height: 24.h),
              const AttendanceCalendarLegend(),
              SizedBox(height: 24.h),
              AttendanceSelectedDayDetails(
                selectedDay: _selectedDay,
                attendanceMap: attendanceMap,
              ),
            ],
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

  Map<DateTime, AttendanceEntity> _createAttendanceMap(
      List<AttendanceEntity> attendanceList) {
    final Map<DateTime, AttendanceEntity> attendanceMap = {};
    for (final attendance in attendanceList) {
      try {
        final date = DateTime.parse(attendance.date);
        final dateKey = DateTime(date.year, date.month, date.day);
        attendanceMap[dateKey] = attendance;
      } catch (e) {
        debugPrint('Error parsing date: ${attendance.date}');
      }
    }
    return attendanceMap;
  }
}
