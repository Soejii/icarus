import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_transaction_model.freezed.dart';
part 'bill_transaction_model.g.dart';

@freezed
class BillTransactionModel with _$BillTransactionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BillTransactionModel({
    required int id,
    required int billId,
    String? payDate,
    required String status,
    @Default(0) int payAmount,
    String? payMethod,
    String? evidencePath,
    @Default(0) int discount,
    String? notes,
    required BillNestedModel bill,
  }) = _BillTransactionModel;

  factory BillTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$BillTransactionModelFromJson(json);
}

@freezed
class BillNestedModel with _$BillNestedModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BillNestedModel({
    required int id,
    required String name,
    @Default(0) int amount,
    @Default(0) int beforeDiscount,
    required String type,
    String? startDate,
    String? endDate,
    String? month,
    @Default(0) int isInstallment,
  }) = _BillNestedModel;

  factory BillNestedModel.fromJson(Map<String, dynamic> json) =>
      _$BillNestedModelFromJson(json);
}
