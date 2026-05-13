import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method_model.freezed.dart';
part 'payment_method_model.g.dart';

@freezed
class PaymentMethodModel with _$PaymentMethodModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaymentMethodModel({
    required int id,
    required String name,
    required String slug,
    @Default(true) bool status,
  }) = _PaymentMethodModel;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
}
