import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

@freezed
class AnnouncementModel with _$AnnouncementModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AnnouncementModel({
    required int id,
    String? title,
    String? photo,
    String? startDate,
    String? description,
  }) = _AnnouncementModel;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);
}
