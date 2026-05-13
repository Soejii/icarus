import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/features/finance/data/models/bill_transaction_model.dart';
import 'package:icarus/shared/core/utils/rupiah_parser.dart';

part 'bill_detail_model.freezed.dart';
part 'bill_detail_model.g.dart';

int _safeInt(dynamic v) => RupiahParser.toInt(v);

@freezed
class BillDetailModel with _$BillDetailModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BillDetailModel({
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
    required BillDetailStudentModel student,
    List<BillInstallmentModel>? billInstallmentConfirmed,
    BillInstallmentModel? billInstallmentPendingOrPaid,
    LatestTransactionModel? latestTransactions,
  }) = _BillDetailModel;

  factory BillDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BillDetailModelFromJson(json);
}

@freezed
class BillDetailStudentModel with _$BillDetailStudentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BillDetailStudentModel({
    required String name,
    required String nis,
    String? className,
  }) = _BillDetailStudentModel;

  factory BillDetailStudentModel.fromJson(Map<String, dynamic> json) =>
      _$BillDetailStudentModelFromJson(json);
}

@freezed
class BillInstallmentModel with _$BillInstallmentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BillInstallmentModel({
    @JsonKey(fromJson: _safeInt) required int id,
    String? payDate,
    @JsonKey(fromJson: _safeInt) @Default(0) int payAmount,
    @Default('') String payMethod,
    @Default('unpaid') String status,
  }) = _BillInstallmentModel;

  factory BillInstallmentModel.fromJson(Map<String, dynamic> json) =>
      _$BillInstallmentModelFromJson(json);
}

@freezed
class LatestTransactionModel with _$LatestTransactionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LatestTransactionModel({
    String? redirectUrl,
    String? virtualAccount,
    String? trxId,
    String? status,
    @JsonKey(fromJson: _safeNullableInt) int? amount,
  }) = _LatestTransactionModel;

  factory LatestTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$LatestTransactionModelFromJson(json);
}

int? _safeNullableInt(dynamic v) => v == null ? null : RupiahParser.toInt(v);
