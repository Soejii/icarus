import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoney_history_model.g.dart';
part 'emoney_history_model.freezed.dart';

@freezed
class EmoneyHistoryModel with _$EmoneyHistoryModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EmoneyHistoryModel({
    required int id,
    String? amount,
    String? date,
    String? transaction,
    String? status,
  }) = _EmoneyHistoryModel;

  factory EmoneyHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$EmoneyHistoryModelFromJson(json);
}
