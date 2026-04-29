import 'package:icarus/features/konseling/domain/types/konseling_type.dart';

class KonselingEntity {
  final int id;
  final KonselingType type;
  final String topic;
  final String date;
  final int durationMinutes;
  final String? teacherName;
  final String? approach;
  final String? description;
  final String? evaluation;
  final String? attachmentUrl;

  KonselingEntity({
    required this.id,
    required this.type,
    required this.topic,
    required this.date,
    required this.durationMinutes,
    this.teacherName,
    this.approach,
    this.description,
    this.evaluation,
    this.attachmentUrl,
  });
}
