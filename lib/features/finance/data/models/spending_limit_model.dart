import 'package:freezed_annotation/freezed_annotation.dart';

part 'spending_limit_model.freezed.dart';
part 'spending_limit_model.g.dart';

@freezed
class SpendingLimitModel with _$SpendingLimitModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SpendingLimitModel({
    required String type,
    int? amount,
  }) = _SpendingLimitModel;

  factory SpendingLimitModel.fromJson(Map<String, dynamic> json) =>
      _$SpendingLimitModelFromJson(json);
}
