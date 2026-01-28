class CommentEntity {
  final int id;
  final String? text;
  final String? posterName;
  final String? posterPhoto;
  final String? posterDate;

  CommentEntity({
    required this.id,
    required this.text,
    required this.posterName,
    required this.posterPhoto,
    required this.posterDate,
  });
}
