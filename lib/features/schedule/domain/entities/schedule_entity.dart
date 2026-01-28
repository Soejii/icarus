class ScheduleEntity {
  final String id;
  final String subjectName;
  final String teacherName;
  final String startTime;
  final String endTime;
  final DayOfWeek dayOfWeek;
  final String subjectImage;

  const ScheduleEntity({
    required this.id,
    required this.subjectName,
    required this.teacherName,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.subjectImage,
  });
}

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get displayName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Senin';
      case DayOfWeek.tuesday:
        return 'Selasa';
      case DayOfWeek.wednesday:
        return 'Rabu';
      case DayOfWeek.thursday:
        return 'Kamis';
      case DayOfWeek.friday:
        return 'Jumat';
      case DayOfWeek.saturday:
        return 'Sabtu';
      case DayOfWeek.sunday:
        return 'Minggu';
    }
  }

  static List<DayOfWeek> get weekDays => [
        DayOfWeek.monday,
        DayOfWeek.tuesday,
        DayOfWeek.wednesday,
        DayOfWeek.thursday,
        DayOfWeek.friday,
        DayOfWeek.saturday,
        DayOfWeek.sunday,
      ];
}
