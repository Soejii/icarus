class TaskEntity {
  final int id;
  final String? subjectName;
  final String? title;
  final String date;
  final int? score;
  final TaskStatus status;

  TaskEntity({
    required this.id,
    required this.subjectName,
    required this.title,
    required this.date,
    required this.score,
    required this.status,
  });
}

enum TaskStatus {
  submitted,
  assigned,
  review,
  unknown,
}
