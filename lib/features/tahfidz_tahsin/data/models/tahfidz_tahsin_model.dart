import 'package:freezed_annotation/freezed_annotation.dart';

part 'tahfidz_tahsin_model.freezed.dart';
part 'tahfidz_tahsin_model.g.dart';

@freezed
class TahfidzModel with _$TahfidzModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TahfidzModel({
    required int id,
    String? date,
    String? additionSurah,
    String? additionVerse,
    String? additionScore,
    String? reviewSurah,
    String? reviewVerse,
    String? reviewScore,
    String? notes,
    TahfidzTahsinTeacherModel? teacher,
    TahfidzTahsinRombelModel? rombel,
  }) = _TahfidzModel;

  factory TahfidzModel.fromJson(Map<String, dynamic> json) =>
      _$TahfidzModelFromJson(json);
}

@freezed
class TahsinModel with _$TahsinModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TahsinModel({
    required int id,
    String? date,
    String? memorizationSurah,
    String? memorizationVerse,
    String? memorizationScore,
    String? ummiQuran,
    String? ummiQuranVerse,
    String? ummiQuranScore,
    String? notes,
    TahfidzTahsinTeacherModel? teacher,
    TahfidzTahsinRombelModel? rombel,
  }) = _TahsinModel;

  factory TahsinModel.fromJson(Map<String, dynamic> json) =>
      _$TahsinModelFromJson(json);
}

@freezed
class TahfidzTahsinTeacherModel with _$TahfidzTahsinTeacherModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TahfidzTahsinTeacherModel({
    required int id,
    String? name,
  }) = _TahfidzTahsinTeacherModel;

  factory TahfidzTahsinTeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TahfidzTahsinTeacherModelFromJson(json);
}

@freezed
class TahfidzTahsinRombelModel with _$TahfidzTahsinRombelModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TahfidzTahsinRombelModel({
    required int id,
    String? name,
  }) = _TahfidzTahsinRombelModel;

  factory TahfidzTahsinRombelModel.fromJson(Map<String, dynamic> json) =>
      _$TahfidzTahsinRombelModelFromJson(json);
}
