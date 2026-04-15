enum ChangeRequestStatus { pending, approved, rejected }

class ChangeRequestEntity {
  final DateTime requestDate;
  final DateTime? updatedAt;
  final ChangeRequestStatus status;

  ChangeRequestEntity({
    required this.requestDate,
    this.updatedAt,
    required this.status,
  });
}
