import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bill_model.freezed.dart';
part 'home_bill_model.g.dart';

@freezed
class HomeBillModel with _$HomeBillModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HomeBillModel({
    required HomeBillStudentModel student,
    required int unpaidTotal,
    required int unpaidSpp,
    required int unpaidDpp,
    required int unpaidLainnya,
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
