import 'package:icarus/features/performance/data/models/exam_model.dart';
import 'package:icarus/shared/core/domain/entities/exam_entity.dart';

extension ExamMapper on ExamModel {
  ExamEntity toEntity() => ExamEntity(
        id: id,
        subjectName: subjectName,
        title: examTitle,
        date: startAt,
        status: getStatus(),
        score: score,
        kkm: kkm,
        teacherName: teacherName
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
