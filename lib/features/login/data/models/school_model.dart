import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_model.freezed.dart';
part 'school_model.g.dart';

@freezed
class SchoolModel with _$SchoolModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SchoolModel({
    required int id,
    String? name,
    String? photo,
    String? address,
    String? phone,
    String? email,
    String? website,
    String? facebook,
    String? instagram,
    String? youtube,
    String? description,
    String? registrationNumber,
    String? accreditation,
  }) = _SchoolModel;

  factory SchoolModel.fromJson(Map<String, dynamic> json) =>
      _$SchoolModelFromJson(json);
}

