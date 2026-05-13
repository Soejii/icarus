import 'package:freezed_annotation/freezed_annotation.dart';

part 'no_rekening_model.freezed.dart';
part 'no_rekening_model.g.dart';

@freezed
class NoRekeningModel with _$NoRekeningModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NoRekeningModel({
    String? bankLogo,
    required String bankAccount,
    required String bankName,
    required String bankNumber,
    @Default(0) int adminFeeSpp,
    @Default(0) int adminFeeDpp,
    @Default(0) int adminFeeLainnya,
    @Default(0) int adminFeeEmoney,
  }) = _NoRekeningModel;

  factory NoRekeningModel.fromJson(Map<String, dynamic> json) =>
      _$NoRekeningModelFromJson(json);
}
