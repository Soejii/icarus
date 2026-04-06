class ChildEntity {
  const ChildEntity({
    required this.id,
    required this.name,
    required this.nis,
    this.nickname,
    this.photo,
    this.className,
  });

  final int id;
  final String name;
  final String nis;
  final String? nickname;
  final String? photo;
  final String? className;

  /// Display name: nickname if non-empty, else full name
  String get displayName =>
      (nickname != null && nickname!.isNotEmpty) ? nickname! : name;
}
