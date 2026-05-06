class NoteEntity {
  final int id;
  final String? title;
  final String? teacherName;
  final String? teacherPhoto;
  final String? date;
  final String? note;
  final String? file;
  final String? status;
  final String? place;
  final String? clock;

  NoteEntity({
    required this.id,
    required this.title,
    required this.teacherName,
    required this.teacherPhoto,
    required this.date,
    required this.note,
    required this.file,
    required this.status,
    required this.place,
    required this.clock,
  });
}
