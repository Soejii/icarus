import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_model.freezed.dart';
part 'child_model.g.dart';

@freezed
class ChildModel with _$ChildModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ChildModel({
    required int id,
    required String name,
    required String nis,
    String? nickname,
    String? photo,
  }) = _ChildModel;

  factory ChildModel.fromJson(Map<String, dynamic> json) =>
      _$ChildModelFromJson(json);
}
