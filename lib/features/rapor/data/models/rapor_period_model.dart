import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/features/rapor/data/models/rapor_detail_report_model.dart';

part 'rapor_period_model.freezed.dart';
part 'rapor_period_model.g.dart';

@freezed
class RaporPeriodModel with _$RaporPeriodModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RaporPeriodModel({
    required int id,
    int? studentId,
    int? teacherId,
    String? file,
    String? category,
    String? year,
    String? semester,
    String? status,
    String? publishedAt,
    String? revisionNotes,
    String? name,
    String? createdAt,
    String? updatedAt,
    @Default(<RaporDetailReportModel>[])
    List<RaporDetailReportModel> detailReport,
  }) = _RaporPeriodModel;

  factory RaporPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$RaporPeriodModelFromJson(json);
}
