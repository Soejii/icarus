import 'package:flutter/material.dart';
import 'package:gaia/features/attendance/domain/entities/attendance_entitiy.dart';
import 'package:gaia/features/attendance/presentation/widgets/attendance_calendar_day.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendarTable extends StatelessWidget {
  final Map<DateTime, AttendanceEntity> attendanceMap;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;

  const AttendanceCalendarTable({
    super.key,
    required this.attendanceMap,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar<AttendanceEntity>(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      calendarFormat: CalendarFormat.month,
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      calendarBuilders: CalendarBuilders<AttendanceEntity>(
        defaultBuilder: (context, day, focusedDay) {
          final attendanceEntity =
              attendanceMap[DateTime(day.year, day.month, day.day)];
          return AttendanceCalendarDay(
            day: day,
            attendanceEntity: attendanceEntity,
            isToday: false,
          );
        },
        todayBuilder: (context, day, focusedDay) {
          final attendanceEntity =
              attendanceMap[DateTime(day.year, day.month, day.day)];
          return AttendanceCalendarDay(
            day: day,
            attendanceEntity: attendanceEntity,
            isToday: true,
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          final attendanceEntity =
              attendanceMap[DateTime(day.year, day.month, day.day)];
          return AttendanceCalendarDay(
            day: day,
            attendanceEntity: attendanceEntity,
            isToday: isSameDay(day, DateTime.now()),
          );
        },
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        weekendStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}