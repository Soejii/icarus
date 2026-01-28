import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_module_model.g.dart';
part 'sub_module_model.freezed.dart';

@freezed
class SubModuleModel with _$SubModuleModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SubModuleModel({
    required int id,
    String? title,
    int? isUploaded,
    int? examCount,
    int? quizCount,
  }) = _SubModuleModel;

  factory SubModuleModel.fromJson(Map<String, dynamic> json) =>
      _$SubModuleModelFromJson(json);
}
