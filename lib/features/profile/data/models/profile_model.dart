import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.g.dart';
part 'profile_model.freezed.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "nis") String? nis,
    @JsonKey(name: "nisn") String? nisn,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "photo") String? photo,
    @JsonKey(name: "gender") String? gender,
    @JsonKey(name: "username") String? username,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "birthplace") String? birthplace,
    @JsonKey(name: "birthdate") String? birthdate,
    @JsonKey(name: "religion") String? religion,
    @JsonKey(name: "address") String? address,
    @JsonKey(name: "rt") String? rt,
    @JsonKey(name: "rw") String? rw,
    @JsonKey(name: "dusun") String? dusun,
    @JsonKey(name: "kelurahan") String? kelurahan,
    @JsonKey(name: "kecamatan") String? kecamatan,
    @JsonKey(name: "code_pos") String? codePos,
    @JsonKey(name: "school_origin") String? schoolOrigin,
    @JsonKey(name: "class_name") String? className,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}


