class AbsenceLetterEntity {
  final int id;
  final int studentId;
  final String status;
  final String date;
  final String? notes;
  final String? evidencePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AbsenceLetterEntity({
    required this.id,
    required this.studentId,
    required this.status,
    required this.date,
    this.notes,
    this.evidencePath,
    this.createdAt,
    this.updatedAt,
  });

  String get type {
    return switch (status) {
      'sick' => 'Sakit',
      'permit' => 'Izin',
      'absent' || 'not_attend' => 'Tidak Hadir',
      'attend' => 'Hadir',
      _ => status,
    };
  }

  String get description => notes?.isNotEmpty == true ? notes! : '-';

  bool get isEditable => status == 'sick' || status == 'permit';
}
