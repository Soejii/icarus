import 'package:gaia/features/task/data/models/task_model.dart';
import 'package:gaia/shared/core/domain/entities/task_entity.dart';

extension TaskMapper on TaskModel {
  TaskEntity toEntity() => TaskEntity(
        id: id,
        subjectName: subject,
        title: title,
        date: date ?? '-',
        score: score,
        status: getStatus(),
      );

  TaskStatus getStatus() {
    switch (status) {
      case 'diberikan':
        return TaskStatus.assigned;
      case 'dikumpulkan':
        return (score == null) ? TaskStatus.review : TaskStatus.submitted;
      default:
        return TaskStatus.unknown;
    }
  }
}
