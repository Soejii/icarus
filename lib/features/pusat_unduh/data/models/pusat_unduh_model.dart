import 'package:freezed_annotation/freezed_annotation.dart';

part 'pusat_unduh_model.freezed.dart';
part 'pusat_unduh_model.g.dart';

@freezed
class PusatUnduhModel with _$PusatUnduhModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PusatUnduhModel({
    required int id,
    String? title,
    String? startDate,
    String? endDate,
    String? file,
    PusatUnduhUserModel? user,
  }) = _PusatUnduhModel;

  factory PusatUnduhModel.fromJson(Map<String, dynamic> json) =>
      _$PusatUnduhModelFromJson(json);
}

@freezed
class PusatUnduhUserModel with _$PusatUnduhUserModel {
  const factory PusatUnduhUserModel({
    required int id,
    String? name,
  }) = _PusatUnduhUserModel;

  factory PusatUnduhUserModel.fromJson(Map<String, dynamic> json) =>
      _$PusatUnduhUserModelFromJson(json);
}
