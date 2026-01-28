class ExamEntity {
  final int id;
  final String? subjectName;
  final String? title;
  final String? date;
  final ExamStatus status;
  final int? score;

  ExamEntity({
    required this.id,
    required this.subjectName,
    required this.title,
    required this.date,
    required this.status,
    required this.score,
  });
}

enum ExamStatus { done, notDone, review, process, unknown }
