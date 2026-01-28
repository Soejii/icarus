class LoginEntity {
  final String token;
  final String schoolName;
  final int schoolId;
  final int userId;

  LoginEntity({
    required this.token,
    required this.schoolName,
    required this.schoolId,
    required this.userId,
  });
}
