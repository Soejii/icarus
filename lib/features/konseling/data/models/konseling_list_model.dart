import 'package:freezed_annotation/freezed_annotation.dart';

part 'konseling_list_model.freezed.dart';
part 'konseling_list_model.g.dart';

@freezed
class KonselingListModel with _$KonselingListModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory KonselingListModel({
    required int id,
    String? topic,
    String? date,
    int? duration,
  }) = _KonselingListModel;

  factory KonselingListModel.fromJson(Map<String, dynamic> json) =>
      _$KonselingListModelFromJson(json);
}
