enum ChangeRequestStatus { menunggu, disetujui, ditolak }

class ChangeRequestEntity {
  final DateTime tanggalPermintaan;
  final DateTime? tanggalUpdate;
  final ChangeRequestStatus status;

  ChangeRequestEntity({
    required this.tanggalPermintaan,
    this.tanggalUpdate,
    required this.status,
  });
}
