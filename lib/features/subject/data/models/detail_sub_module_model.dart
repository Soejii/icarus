import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_sub_module_model.g.dart';
part 'detail_sub_module_model.freezed.dart';

@freezed
class DetailSubModuleModel with _$DetailSubModuleModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory DetailSubModuleModel({
    required int id,
    String? title,
    String? description,
    String? file,
    String? createdAt,
    String? publishDate,
  }) = _DetailSubModuleModel;

  factory DetailSubModuleModel.fromJson(Map<String, dynamic> json) =>
      _$DetailSubModuleModelFromJson(json);
}
