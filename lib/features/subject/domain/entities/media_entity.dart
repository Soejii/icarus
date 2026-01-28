import 'package:gaia/features/subject/domain/types/media_type.dart';

class MediaEntity {
  final int id;
  final String? name;
  final String? link;
  final String? date;
  final MediaType type;

  MediaEntity({
    required this.id,
    required this.name,
    required this.link,
    required this.date,
    required this.type,
  });
}
