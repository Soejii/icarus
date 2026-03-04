import 'package:icarus/features/profile/domain/entities/user_entity.dart';

class ProfileEntity {
  final String name;
  final String className;
  final String imgUrl;
  final String username;
  final String email;
  final String birthplace;
  final String birthdate;
  final String religion;
  final String address;
  final String nik;
  final String phone;
  final UserEntity? user;

  ProfileEntity({
    required this.name,
    required this.className,
    required this.imgUrl,
    required this.username,
    required this.email,
    required this.birthplace,
    required this.birthdate,
    required this.religion,
    required this.address,
    required this.nik,
    required this.phone,
    this.user,
  });
}
