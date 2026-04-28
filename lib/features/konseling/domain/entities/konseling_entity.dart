import 'package:icarus/features/konseling/domain/types/konseling_type.dart';

class KonselingEntity {
  final int id;
  final KonselingType type;
  final String topik;
  final String tanggal;
  final int durasiMenit;
  final String namaGuru;
  final String pendekatan;
  final String deskripsi;
  final String evaluasi;
  final String? lampiranUrl;

  KonselingEntity({
    required this.id,
    required this.type,
    required this.topik,
    required this.tanggal,
    required this.durasiMenit,
    required this.namaGuru,
    required this.pendekatan,
    required this.deskripsi,
    required this.evaluasi,
    this.lampiranUrl,
  });
}
