import 'package:freezed_annotation/freezed_annotation.dart';

part 'saving_transaction_model.freezed.dart';
part 'saving_transaction_model.g.dart';

@freezed
class SavingTransactionModel with _$SavingTransactionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SavingTransactionModel({
    required int id,
    required dynamic amount,
    String? notes,
    required String type,
    @Default(0) int confirmed,
    required String transaction,
    String? date,
    String? confirmationPhoto,
    String? receivedBy,
    String? givenBy,
  }) = _SavingTransactionModel;

  factory SavingTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$SavingTransactionModelFromJson(json);
}
