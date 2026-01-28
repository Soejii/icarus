import 'package:freezed_annotation/freezed_annotation.dart';

part 'savings_model.g.dart';
part 'savings_model.freezed.dart';

@freezed
class SavingsModel with _$SavingsModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SavingsModel({
    String? name,
    String? cardId,
    String? saldoTopup,
    String? totalTopup,
    String? totalCashout,
  }) = _SavingsModel;

  factory SavingsModel.fromJson(Map<String, dynamic> json) =>
      _$SavingsModelFromJson(json);
}
