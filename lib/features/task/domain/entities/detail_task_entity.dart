class DetailTaskEntity {
  final int id;
  final String? title;
  final int? score;
  final String? instruction;
  final String? startAt;
  final String? finishAt;
  final String? dateSubmit;
  final String? teacherName;

  DetailTaskEntity({
    required this.id,
    required this.title,
    required this.score,
    required this.instruction,
    required this.startAt,
    required this.finishAt,
    required this.dateSubmit,
    required this.teacherName,
  });
}
