import 'package:icarus/features/rapor/domain/entities/rapor_detail_report_entity.dart';

class RaporPeriodEntity {
  final int id;
  final int? studentId;
  final String? file;
  final String? category;
  final String? year;
  final String? semester;
  final String? status;
  final DateTime? publishedAt;
  final String? revisionNotes;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<RaporDetailReportEntity> detailReports;

  const RaporPeriodEntity({
    required this.id,
    required this.studentId,
    required this.file,
    required this.category,
    required this.year,
    required this.semester,
    required this.status,
    required this.publishedAt,
    required this.revisionNotes,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.detailReports,
  });

  String get displayTitle {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final y = year?.trim();
    if (y != null && y.isNotEmpty) return 'Rapor $y';
    return 'Rapor';
  }

  String get displaySubtitle {
    final s = semester?.trim();
    return (s == null || s.isEmpty) ? '-' : s;
  }

  bool get hasDetails => detailReports.isNotEmpty;
  bool get hasSingleFile => !hasDetails && file != null && file!.isNotEmpty;
  bool get isExpandable => hasDetails;
  bool get isFlatTappable => hasSingleFile;
  bool get isEmpty => !hasDetails && !hasSingleFile;
}
