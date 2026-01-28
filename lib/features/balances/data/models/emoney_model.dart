import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoney_model.g.dart';
part 'emoney_model.freezed.dart';

@freezed
class EmoneyModel with _$EmoneyModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EmoneyModel({
    String? name,
    String? cardId,
    String? saldoEmoney,
    String? totalTopup,
    String? totalPayment,
    String? totalCashout,
  }) = _EmoneyModel;

  factory EmoneyModel.fromJson(Map<String, dynamic> json) =>
      _$EmoneyModelFromJson(json);
}