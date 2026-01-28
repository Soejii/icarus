import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_magazine_model.g.dart';
part 'digital_magazine_model.freezed.dart';

@freezed
class DigitalMagazineModel with _$DigitalMagazineModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalMagazineModel({
    required int id,
    String? name,
    String? photo,
    String? startDate,
    String? endDate,
    String? createdAt
  }) = _DigitalMagazineModel;

  factory DigitalMagazineModel.fromJson(Map<String, dynamic> json) =>
      _$DigitalMagazineModelFromJson(json);
}
