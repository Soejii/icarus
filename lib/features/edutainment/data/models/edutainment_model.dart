import 'package:freezed_annotation/freezed_annotation.dart';

part 'edutainment_model.g.dart';
part 'edutainment_model.freezed.dart';

@freezed
class EdutainmentModel with _$EdutainmentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EdutainmentModel({
    required int id,
    String? title,
    String? thumbnail,
    String? link,
    String? createdAt,
    String? description,
  }) = _EdutainmentModel;

  factory EdutainmentModel.fromJson(Map<String, dynamic> json) =>
      _$EdutainmentModelFromJson(json);
}
