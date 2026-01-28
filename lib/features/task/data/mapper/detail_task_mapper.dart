import 'package:gaia/features/task/data/models/detail_task_model.dart';
import 'package:gaia/features/task/domain/entities/detail_task_entity.dart';

extension DetailTaskMapper on DetailTaskModel {
  DetailTaskEntity toEntity() => DetailTaskEntity(
        id: id,
        title: title,
        score: score,
        instruction: instruction,
        startAt: startAt,
        finishAt: finishAt,
        dateSubmit: dateSubmit,
        teacherName: teacherName,
      );
}
