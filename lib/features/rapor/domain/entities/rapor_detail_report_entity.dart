class RaporDetailReportEntity {
  final int id;
  final int? reportId;
  final String? name;
  final String? fileUrl;
  final int fallbackIndex;

  const RaporDetailReportEntity({
    required this.id,
    required this.reportId,
    required this.name,
    required this.fileUrl,
    required this.fallbackIndex,
  });

  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    return 'Dokumen ${fallbackIndex + 1}';
  }

  bool get hasFile => fileUrl != null && fileUrl!.isNotEmpty;
}
