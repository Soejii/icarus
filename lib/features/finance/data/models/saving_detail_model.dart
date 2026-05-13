import 'package:freezed_annotation/freezed_annotation.dart';

part 'saving_detail_model.freezed.dart';
part 'saving_detail_model.g.dart';

@freezed
class SavingDetailModel with _$SavingDetailModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SavingDetailModel({
    required String name,
    String? schoolName,
    String? cardId,
    required dynamic saldoTopup,
    required dynamic totalTopup,
    required dynamic totalCashout,
    required dynamic totalTransaction,
  }) = _SavingDetailModel;

  factory SavingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SavingDetailModelFromJson(json);
}
