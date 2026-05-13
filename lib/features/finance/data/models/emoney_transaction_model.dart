import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoney_transaction_model.freezed.dart';
part 'emoney_transaction_model.g.dart';

@freezed
class EmoneyTransactionModel with _$EmoneyTransactionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EmoneyTransactionModel({
    required int id,
    required dynamic amount,
    String? notes,
    required String type,
    required String transaction,
    required String status,
    String? date,
    String? confirmationPhoto,
    String? merchantName,
    String? listItem,
    EmoneyStudentModel? student,
    String? transactionName,
  }) = _EmoneyTransactionModel;

  factory EmoneyTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$EmoneyTransactionModelFromJson(json);
}

@freezed
class EmoneyStudentModel with _$EmoneyStudentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EmoneyStudentModel({
    required String name,
    String? nis,
  }) = _EmoneyStudentModel;

  factory EmoneyStudentModel.fromJson(Map<String, dynamic> json) =>
      _$EmoneyStudentModelFromJson(json);
}
