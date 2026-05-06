class ClassNoteFile {
  final int id;
  final String? file;

  ClassNoteFile({required this.id, required this.file});
}

class ClassNoteDetailEntity {
  final int id;
  final String? title;
  final String? date;
  final String? notes;
  final int? teacherId;
  final String? teacherName;
  final List<ClassNoteFile> files;

  ClassNoteDetailEntity({
    required this.id,
    this.title,
    this.date,
    this.notes,
    this.teacherId,
    this.teacherName,
    this.files = const [],
  });
}
