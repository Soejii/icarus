class ChildEntity {
  const ChildEntity({
    required this.id,
    required this.name,
    required this.nis,
    this.photo,
    this.className,
  });

  final int id;
  final String name;
  final String nis;
  final String? photo;
  final String? className;
}
