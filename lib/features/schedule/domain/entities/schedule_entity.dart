import 'package:flutter/foundation.dart';

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get displayName => switch (this) {
        DayOfWeek.monday => 'Senin',
        DayOfWeek.tuesday => 'Selasa',
        DayOfWeek.wednesday => 'Rabu',
        DayOfWeek.thursday => 'Kamis',
        DayOfWeek.friday => "Jum'at",
        DayOfWeek.saturday => 'Sabtu',
        DayOfWeek.sunday => 'Minggu',
      };

  String get apiValue => switch (this) {
        DayOfWeek.monday => 'senin',
        DayOfWeek.tuesday => 'selasa',
        DayOfWeek.wednesday => 'rabu',
        DayOfWeek.thursday => 'kamis',
        DayOfWeek.friday => 'jumat',
        DayOfWeek.saturday => 'sabtu',
        DayOfWeek.sunday => 'minggu',
      };

  static List<DayOfWeek> get weekDays =>
      [monday, tuesday, wednesday, thursday, friday, saturday];
}

@immutable
class ScheduleEntity {
  const ScheduleEntity({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.subjectName,
    required this.teacherName,
  });

  final int id;
  final DayOfWeek day;
  final String startTime;
  final String endTime;
  final String subjectName;
  final String teacherName;
}
