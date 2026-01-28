import 'package:freezed_annotation/freezed_annotation.dart';

part 'savings_history_model.freezed.dart';
part 'savings_history_model.g.dart';

@freezed
class SavingsHistoryModel with _$SavingsHistoryModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SavingsHistoryModel({
    required int id,
    String? date,
    int? amount,
    int? confirmed,
    String? transaction,
  }) = _SavingsHistoryModel;

  factory SavingsHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SavingsHistoryModelFromJson(json);
}
