class NoteEntity {
  final int id;
  final String? title;
  final String? teacherName;
  final String? date;
  final String? note;
  final String? file;

  NoteEntity({
    required this.id,
    required this.title,
    required this.teacherName,
    required this.date,
    required this.note,
    required this.file,
  });
}
