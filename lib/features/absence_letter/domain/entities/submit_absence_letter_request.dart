class SubmitAbsenceLetterRequest {
  final int studentId;
  final String status;
  final String evidencePath;
  final String notes;
  final String startDate;
  final String endDate;

  const SubmitAbsenceLetterRequest({
    required this.studentId,
    required this.status,
    required this.evidencePath,
    required this.notes,
    required this.startDate,
    required this.endDate,
  });
}
