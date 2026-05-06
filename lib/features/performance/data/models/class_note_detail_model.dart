import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_note_detail_model.freezed.dart';
part 'class_note_detail_model.g.dart';

@freezed
class ClassNoteDetailModel with _$ClassNoteDetailModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ClassNoteDetailModel({
    required int id,
    String? title,
    String? date,
    String? notes,
    int? teacherId,
    String? teacherName,
    List<ClassNoteFileModel>? files,
  }) = _ClassNoteDetailModel;

  factory ClassNoteDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ClassNoteDetailModelFromJson(json);
}

@freezed
class ClassNoteFileModel with _$ClassNoteFileModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ClassNoteFileModel({
    required int id,
    String? file,
  }) = _ClassNoteFileModel;

  factory ClassNoteFileModel.fromJson(Map<String, dynamic> json) =>
      _$ClassNoteFileModelFromJson(json);
}
