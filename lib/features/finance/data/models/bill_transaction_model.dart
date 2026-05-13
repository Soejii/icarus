import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/shared/core/utils/rupiah_parser.dart';

part 'bill_transaction_model.freezed.dart';
part 'bill_transaction_model.g.dart';

int _safeInt(dynamic v) => RupiahParser.toInt(v);
int? _safeNullableInt(dynamic v) => v == null ? null : RupiahParser.toInt(v);

@freezed
class BillTransactionModel with _$BillTransactionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BillTransactionModel({
    @JsonKey(fromJson: _safeInt) required int id,
    @JsonKey(fromJson: _safeInt) required int billId,
    String? payDate,
    required String status,
    @JsonKey(fromJson: _safeInt) @Default(0) int payAmount,
    String? payMethod,
    String? evidencePath,
    @JsonKey(fromJson: _safeInt) @Default(0) int discount,
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
    @JsonKey(fromJson: _safeInt) required int id,
    required String name,
    @JsonKey(fromJson: _safeInt) @Default(0) int amount,
    @JsonKey(fromJson: _safeInt) @Default(0) int beforeDiscount,
    required String type,
    String? startDate,
    String? endDate,
    String? month,
    @JsonKey(fromJson: _safeInt) @Default(0) int isInstallment,
  }) = _BillNestedModel;

  factory BillNestedModel.fromJson(Map<String, dynamic> json) =>
      _$BillNestedModelFromJson(json);
}
