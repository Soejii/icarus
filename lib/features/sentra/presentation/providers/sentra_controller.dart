import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sentra_controller.g.dart';

const _mockSentra = [
  (
    id: 1,
    namaSentra: 'SENI TARI',
    tanggal: 'Kamis, 20 Juni 2025',
    rombel: 'Seni Tari Tradisional',
    namaGuru: 'Budi Susanto',
    keterangan: 'Gerakan Dasar',
    nilai: 90,
    deskripsi: 'Ananda sudah melakukan dengan baik',
  ),
  (
    id: 2,
    namaSentra: 'SENI MUSIK',
    tanggal: 'Senin, 16 Juni 2025',
    rombel: 'Musik Tradisional',
    namaGuru: 'Siti Rahayu',
    keterangan: 'Teknik Dasar',
    nilai: 85,
    deskripsi: 'Ananda menunjukkan perkembangan yang baik dalam memainkan alat musik',
  ),
  (
    id: 3,
    namaSentra: 'SAINS',
    tanggal: 'Rabu, 11 Juni 2025',
    rombel: 'Eksperimen Dasar',
    namaGuru: 'Dewi Lestari',
    keterangan: 'Praktikum',
    nilai: 88,
    deskripsi: 'Ananda aktif dan antusias dalam setiap kegiatan sains',
  ),
  (
    id: 4,
    namaSentra: 'BAHASA',
    tanggal: 'Jumat, 6 Juni 2025',
    rombel: 'Literasi Awal',
    namaGuru: 'Budi Susanto',
    keterangan: 'Membaca dan Menulis',
    nilai: 92,
    deskripsi: 'Ananda sangat lancar dalam membaca dan menulis',
  ),
  (
    id: 5,
    namaSentra: 'SENI RUPA',
    tanggal: 'Selasa, 3 Juni 2025',
    rombel: 'Menggambar Dasar',
    namaGuru: 'Siti Rahayu',
    keterangan: 'Kreativitas',
    nilai: 87,
    deskripsi: 'Ananda memiliki kreativitas tinggi dalam setiap karya seni',
  ),
  (
    id: 6,
    namaSentra: 'OLAHRAGA',
    tanggal: 'Kamis, 29 Mei 2025',
    rombel: 'Gerak Dasar',
    namaGuru: 'Dewi Lestari',
    keterangan: 'Koordinasi Motorik',
    nilai: 91,
    deskripsi: 'Ananda memiliki koordinasi motorik yang sangat baik',
  ),
];

@riverpod
class SentraController extends _$SentraController {
  @override
  List<SentraEntity> build() {
    return _mockSentra
        .map(
          (e) => SentraEntity(
            id: e.id,
            namaSentra: e.namaSentra,
            tanggal: e.tanggal,
            rombel: e.rombel,
            namaGuru: e.namaGuru,
            keterangan: e.keterangan,
            nilai: e.nilai,
            deskripsi: e.deskripsi,
          ),
        )
        .toList();
  }
}

@riverpod
class DetailSentraController extends _$DetailSentraController {
  @override
  SentraEntity build(int id) {
    final match = _mockSentra.firstWhere(
      (e) => e.id == id,
      orElse: () => _mockSentra.first,
    );
    return SentraEntity(
      id: match.id,
      namaSentra: match.namaSentra,
      tanggal: match.tanggal,
      rombel: match.rombel,
      namaGuru: match.namaGuru,
      keterangan: match.keterangan,
      nilai: match.nilai,
      deskripsi: match.deskripsi,
    );
  }
}
