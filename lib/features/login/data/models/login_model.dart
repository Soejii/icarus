import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icarus/features/login/data/models/school_model.dart';
import 'package:icarus/features/login/data/models/user_model.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginResponseModel with _$LoginResponseModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory LoginResponseModel({
    required String accessToken,
    String? tokenType,
    String? expiresIn,
    SchoolModel? school,
    UserModel? user,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
