import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
class ContactModel with _$ContactModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ContactModel({
    int? userId,
    String? role,
    @JsonKey(name: 'class') String? className,
    String? name,
    String? photo,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
}