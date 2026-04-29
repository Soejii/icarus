import 'package:freezed_annotation/freezed_annotation.dart';

part 'konseling_detail_model.freezed.dart';
part 'konseling_detail_model.g.dart';

@freezed
class KonselingDetailModel with _$KonselingDetailModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory KonselingDetailModel({
    required int id,
    String? type,
    String? teacherName,
    String? date,
    int? duration,
    String? topic,
    String? approach,
    String? description,
    @JsonKey(name: 'evalutation') String? evaluasi,
    String? attachment,
  }) = _KonselingDetailModel;

  factory KonselingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$KonselingDetailModelFromJson(json);
}
