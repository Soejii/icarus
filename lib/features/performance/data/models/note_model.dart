import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/shared/core/data/models/teacher_model.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NoteModel({
    required int id,
    String? title,
    String? date,
    String? file,
    TeacherModel? teacher,
    String? notes,
    String? status,
    String? place,
    String? clock,
    String? poin,
    String? noteHeadmaster,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}
