import 'package:icarus/features/performance/data/models/note_model.dart';
import 'package:icarus/features/performance/domain/entities/note_entity.dart';

extension NoteMapper on NoteModel {
  NoteEntity toEntity() => NoteEntity(
        id: id,
        title: title,
        teacherName: teacher?.name,
        date: date,
        note: notes,
        file: file,
      );
}
