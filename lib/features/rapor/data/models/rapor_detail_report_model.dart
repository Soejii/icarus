import 'package:freezed_annotation/freezed_annotation.dart';

part 'rapor_detail_report_model.freezed.dart';
part 'rapor_detail_report_model.g.dart';

@freezed
class RaporDetailReportModel with _$RaporDetailReportModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RaporDetailReportModel({
    required int id,
    int? reportId,
    String? name,
    String? file,
    String? createdAt,
    String? updatedAt,
  }) = _RaporDetailReportModel;

  factory RaporDetailReportModel.fromJson(Map<String, dynamic> json) =>
      _$RaporDetailReportModelFromJson(json);
}
