import 'package:icarus/features/performance/data/models/class_note_detail_model.dart';
import 'package:icarus/features/performance/domain/entities/class_note_detail_entity.dart';

extension ClassNoteDetailMapper on ClassNoteDetailModel {
  ClassNoteDetailEntity toEntity() => ClassNoteDetailEntity(
        id: id,
        title: title,
        date: date,
        notes: notes,
        teacherId: teacherId,
        teacherName: teacherName,
        files: files
                ?.map(
                  (file) => ClassNoteFile(id: file.id, file: file.file),
                )
                .toList() ??
            [],
      );
}
