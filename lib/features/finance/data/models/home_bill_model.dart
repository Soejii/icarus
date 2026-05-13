import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/shared/core/utils/rupiah_parser.dart';

part 'home_bill_model.freezed.dart';
part 'home_bill_model.g.dart';

int _safeInt(dynamic v) => RupiahParser.toInt(v);

@freezed
class HomeBillModel with _$HomeBillModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HomeBillModel({
    required HomeBillStudentModel student,
    @JsonKey(fromJson: _safeInt) required int unpaidTotal,
    @JsonKey(fromJson: _safeInt) required int unpaidSpp,
    @JsonKey(fromJson: _safeInt) required int unpaidDpp,
    @JsonKey(fromJson: _safeInt) required int unpaidLainnya,
    String? info,
  }) = _HomeBillModel;

  factory HomeBillModel.fromJson(Map<String, dynamic> json) =>
      _$HomeBillModelFromJson(json);
}

@freezed
class HomeBillStudentModel with _$HomeBillStudentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HomeBillStudentModel({
    required String name,
    required String nis,
    @JsonKey(name: 'class') required String className,
  }) = _HomeBillStudentModel;

  factory HomeBillStudentModel.fromJson(Map<String, dynamic> json) =>
      _$HomeBillStudentModelFromJson(json);
}
