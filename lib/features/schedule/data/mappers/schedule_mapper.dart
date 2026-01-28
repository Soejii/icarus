import 'package:gaia/features/schedule/domain/entities/schedule_entity.dart';
import 'package:gaia/features/schedule/data/models/schedule_model.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';

extension ScheduleEntityMapper on ScheduleModel {
  ScheduleEntity toEntity() => ScheduleEntity(
        id: id.toString(),
        subjectName: subject.name ?? '-',
        teacherName: teacher.name,
        startTime: startTime,
        endTime: endTime,
        dayOfWeek: _mapDayOfWeek(day),
        subjectImage: _mapSubjectImage(subject.iconCode ?? ''),
      );

  DayOfWeek _mapDayOfWeek(String day) {
    switch (day.toLowerCase()) {
      case 'senin':
        return DayOfWeek.monday;
      case 'selasa':
        return DayOfWeek.tuesday;
      case 'rabu':
        return DayOfWeek.wednesday;
      case 'kamis':
        return DayOfWeek.thursday;
      case 'jumat':
        return DayOfWeek.friday;
      case 'sabtu':
        return DayOfWeek.saturday;
      case 'minggu':
        return DayOfWeek.sunday;
      default:
        return DayOfWeek.monday;
    }
  }

  String _mapSubjectImage(String iconCode) {
    switch (iconCode.toLowerCase()) {
      case 'biologi':
        return AssetsHelper.imgSubjectBiologi;
      case 'fisika':
        return AssetsHelper.imgSubjectFisika;
      case 'matematika':
        return AssetsHelper.imgSubjectMatematika;
      case 'sejarah':
        return AssetsHelper.imgSubjectSejarah;
      case 'indonesia':
      case 'bahasa indonesia':
        return AssetsHelper.imgSubjectIndonesia;
      case 'ipa':
        return AssetsHelper.imgSubjectIpa;
      default:
        return AssetsHelper.imgSubjectPlaceholder;
    }
  }
}