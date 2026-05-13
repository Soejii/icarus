import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoney_detail_model.freezed.dart';
part 'emoney_detail_model.g.dart';

@freezed
class EmoneyDetailModel with _$EmoneyDetailModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EmoneyDetailModel({
    required String name,
    String? schoolName,
    String? cardId,
    required dynamic saldoEmoney,
    required dynamic totalTopup,
    required dynamic totalPayment,
    required dynamic totalCashout,
    required dynamic totalTransaction,
  }) = _EmoneyDetailModel;

  factory EmoneyDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EmoneyDetailModelFromJson(json);
}
