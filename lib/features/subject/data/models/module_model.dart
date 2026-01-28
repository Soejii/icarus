import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gaia/features/subject/data/models/sub_module_model.dart';

part 'module_model.g.dart';
part 'module_model.freezed.dart';

@freezed
class ModuleModel with _$ModuleModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ModuleModel({
    required int id,
    String? title,
    int? subModuleCount,
    int? examCount,
    int? quizCount,
    List<SubModuleModel>? subModule,
  }) = _ModuleModel;

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);
}
