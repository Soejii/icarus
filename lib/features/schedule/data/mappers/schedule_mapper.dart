import 'package:icarus/features/schedule/data/models/schedule_model.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';

extension ScheduleMapper on ScheduleModel {
  ScheduleEntity toEntity() => ScheduleEntity(
        id: id,
        day: _parseDay(day),
        startTime: startTime,
        endTime: endTime,
        subjectName: subject.name,
        teacherName: teacher.name,
      );

  DayOfWeek _parseDay(String raw) => switch (raw.toLowerCase()) {
        'senin' => DayOfWeek.monday,
        'selasa' => DayOfWeek.tuesday,
        'rabu' => DayOfWeek.wednesday,
        'kamis' => DayOfWeek.thursday,
        'jumat' => DayOfWeek.friday,
        "jum'at" => DayOfWeek.friday,
        'sabtu' => DayOfWeek.saturday,
        'minggu' => DayOfWeek.sunday,
        _ => DayOfWeek.monday,
      };
}
