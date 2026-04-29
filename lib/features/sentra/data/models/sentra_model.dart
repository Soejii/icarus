import 'package:freezed_annotation/freezed_annotation.dart';

part 'sentra_model.freezed.dart';
part 'sentra_model.g.dart';

@freezed
class SentraModel with _$SentraModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SentraModel({
    required int id,
    String? note,
    String? score,
    String? description,
    String? createdAt,
    SentraRombelModel? sentraRombel,
    TeacherSimpleModel? teacher,
  }) = _SentraModel;

  factory SentraModel.fromJson(Map<String, dynamic> json) =>
      _$SentraModelFromJson(json);
}

@freezed
class SentraRombelModel with _$SentraRombelModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SentraRombelModel({
    required int id,
    String? name,
    SentraNameModel? sentra,
  }) = _SentraRombelModel;

  factory SentraRombelModel.fromJson(Map<String, dynamic> json) =>
      _$SentraRombelModelFromJson(json);
}

@freezed
class SentraNameModel with _$SentraNameModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SentraNameModel({
    required int id,
    String? sentraName,
  }) = _SentraNameModel;

  factory SentraNameModel.fromJson(Map<String, dynamic> json) =>
      _$SentraNameModelFromJson(json);
}

@freezed
class TeacherSimpleModel with _$TeacherSimpleModel {
  const factory TeacherSimpleModel({
    required int id,
    String? name,
  }) = _TeacherSimpleModel;

  factory TeacherSimpleModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherSimpleModelFromJson(json);
}
