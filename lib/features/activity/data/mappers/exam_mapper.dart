import 'package:gaia/features/activity/data/models/exam_model.dart';
import 'package:gaia/shared/core/domain/entities/exam_entity.dart';

extension ExamMapper on ExamModel {
  ExamEntity toEntity() => ExamEntity(
        id: id,
        subjectName: subject,
        title: title ,
        date: startAt,
        score: score,
        status: getStatus(),
      );

  ExamStatus getStatus() {
    switch (status) {
      case 'dikerjakan':
        return ExamStatus.done;
      case 'proses':
        return ExamStatus.process;
      case 'belum dikerjakan':
        return ExamStatus.notDone;
      case 'review':
        return ExamStatus.review;
      default:
        return ExamStatus.unknown;
    }
  }
}
