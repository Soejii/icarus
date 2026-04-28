import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/features/konseling/domain/types/konseling_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'konseling_controller.g.dart';

@riverpod
class KonselingTabIndex extends _$KonselingTabIndex {
  @override
  int build() => 0;
  void set(int newIndex) => state = newIndex;
}

const _mockKonseling = [
  // Siswa entries
  (
    id: 1,
    type: KonselingType.siswa,
    topik: 'Pelanggaran Berseragam',
    tanggal: 'Kamis, 20 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Budi Susanto',
    pendekatan: 'Konseling Individual',
    deskripsi:
        'Siswa menghadapi masalah terkait pelanggaran aturan berseragam di sekolah, '
            'di mana siswa sering kali tidak mematuhi peraturan tentang seragam yang telah '
            'ditentukan, seperti pemakaian atribut yang tidak sesuai, tidak mengenakan '
            'seragam lengkap, atau penggunaan aksesori yang tidak diperbolehkan.',
    evaluasi:
        'Membantu siswa mengidentifikasi alasan di balik pelanggaran tersebut dan '
            'mencari solusi agar siswa dapat mematuhi peraturan tanpa merasa terbebani.',
    lampiranUrl: 'https://example.com/lampiran1.pdf',
  ),
  (
    id: 2,
    type: KonselingType.siswa,
    topik: 'Kesulitan Belajar Matematika',
    tanggal: 'Senin, 16 Juni 2025',
    durasiMenit: 45,
    namaGuru: 'Siti Rahayu',
    pendekatan: 'Konseling Kelompok',
    deskripsi:
        'Siswa mengalami kesulitan dalam memahami materi matematika khususnya pada bab aljabar.',
    evaluasi:
        'Direncanakan sesi tambahan bersama guru matematika untuk memperkuat pemahaman.',
    lampiranUrl: null,
  ),
  (
    id: 3,
    type: KonselingType.siswa,
    topik: 'Konflik dengan Teman Sebaya',
    tanggal: 'Rabu, 11 Juni 2025',
    durasiMenit: 30,
    namaGuru: 'Dewi Lestari',
    pendekatan: 'Mediasi',
    deskripsi:
        'Terdapat ketegangan antara siswa dan beberapa teman di kelas yang mengganggu proses belajar.',
    evaluasi:
        'Kedua pihak telah sepakat untuk saling menghormati dan menyelesaikan perbedaan secara damai.',
    lampiranUrl: null,
  ),
  (
    id: 4,
    type: KonselingType.siswa,
    topik: 'Manajemen Waktu',
    tanggal: 'Jumat, 6 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Budi Susanto',
    pendekatan: 'Konseling Individual',
    deskripsi:
        'Siswa kesulitan mengatur waktu antara kegiatan ekstrakurikuler dan belajar.',
    evaluasi:
        'Siswa diberikan panduan membuat jadwal harian yang seimbang antara kegiatan akademik dan non-akademik.',
    lampiranUrl: 'https://example.com/lampiran4.pdf',
  ),
  (
    id: 5,
    type: KonselingType.siswa,
    topik: 'Motivasi Belajar',
    tanggal: 'Selasa, 3 Juni 2025',
    durasiMenit: 45,
    namaGuru: 'Siti Rahayu',
    pendekatan: 'Konseling Individual',
    deskripsi:
        'Siswa menunjukkan penurunan motivasi belajar yang berdampak pada nilai akademik.',
    evaluasi:
        'Siswa diminta untuk menuliskan tujuan jangka pendek dan panjang sebagai pemicu motivasi.',
    lampiranUrl: null,
  ),
  // Orang Tua entries
  (
    id: 6,
    type: KonselingType.orangTua,
    topik: 'Pola Asuh Anak',
    tanggal: 'Kamis, 20 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Dewi Lestari',
    pendekatan: 'Konseling Keluarga',
    deskripsi:
        'Orang tua mendiskusikan cara memberikan dukungan optimal kepada anak dalam kegiatan belajar di rumah.',
    evaluasi:
        'Orang tua diberikan panduan komunikasi efektif dengan anak agar tercipta lingkungan belajar yang kondusif.',
    lampiranUrl: null,
  ),
  (
    id: 7,
    type: KonselingType.orangTua,
    topik: 'Komunikasi Orang Tua dan Anak',
    tanggal: 'Senin, 16 Juni 2025',
    durasiMenit: 45,
    namaGuru: 'Budi Susanto',
    pendekatan: 'Konseling Keluarga',
    deskripsi:
        'Diskusi mengenai hambatan komunikasi antara orang tua dan anak di rumah.',
    evaluasi:
        'Disarankan orang tua meluangkan waktu berkualitas bersama anak minimal 30 menit per hari.',
    lampiranUrl: null,
  ),
  (
    id: 8,
    type: KonselingType.orangTua,
    topik: 'Dampak Gadget pada Anak',
    tanggal: 'Rabu, 11 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Siti Rahayu',
    pendekatan: 'Konseling Informatif',
    deskripsi:
        'Orang tua khawatir dengan penggunaan gadget yang berlebihan dan dampaknya terhadap prestasi belajar anak.',
    evaluasi:
        'Disepakati aturan penggunaan gadget di rumah dengan batas waktu yang jelas.',
    lampiranUrl: 'https://example.com/lampiran8.pdf',
  ),
  (
    id: 9,
    type: KonselingType.orangTua,
    topik: 'Persiapan Ujian Nasional',
    tanggal: 'Jumat, 6 Juni 2025',
    durasiMenit: 30,
    namaGuru: 'Dewi Lestari',
    pendekatan: 'Konseling Informatif',
    deskripsi:
        'Orang tua ingin mengetahui cara terbaik mendukung anak dalam persiapan ujian nasional.',
    evaluasi:
        'Orang tua diberikan tips mendukung anak belajar tanpa menambah tekanan berlebihan.',
    lampiranUrl: null,
  ),
  (
    id: 10,
    type: KonselingType.orangTua,
    topik: 'Pilihan Jurusan Kuliah',
    tanggal: 'Selasa, 3 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Budi Susanto',
    pendekatan: 'Konseling Karir',
    deskripsi:
        'Diskusi mengenai pilihan jurusan kuliah yang sesuai dengan minat dan bakat anak.',
    evaluasi:
        'Disarankan untuk melakukan tes minat dan bakat sebelum mengambil keputusan.',
    lampiranUrl: null,
  ),
  // Home Visit entries
  (
    id: 11,
    type: KonselingType.homeVisit,
    topik: 'Ketidakhadiran Siswa',
    tanggal: 'Kamis, 20 Juni 2025',
    durasiMenit: 90,
    namaGuru: 'Dewi Lestari',
    pendekatan: 'Kunjungan Rumah',
    deskripsi:
        'Kunjungan ke rumah siswa yang sering tidak masuk sekolah tanpa keterangan yang jelas.',
    evaluasi:
        'Ditemukan faktor keluarga yang perlu ditangani. Koordinasi dengan pihak sekolah dan orang tua akan ditindaklanjuti.',
    lampiranUrl: null,
  ),
  (
    id: 12,
    type: KonselingType.homeVisit,
    topik: 'Kondisi Lingkungan Belajar',
    tanggal: 'Senin, 16 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Siti Rahayu',
    pendekatan: 'Kunjungan Rumah',
    deskripsi:
        'Penilaian kondisi lingkungan belajar siswa di rumah untuk mendukung proses pembelajaran.',
    evaluasi:
        'Orang tua berkomitmen menyediakan ruang belajar yang lebih kondusif.',
    lampiranUrl: null,
  ),
  (
    id: 13,
    type: KonselingType.homeVisit,
    topik: 'Perilaku Agresif Siswa',
    tanggal: 'Rabu, 11 Juni 2025',
    durasiMenit: 75,
    namaGuru: 'Budi Susanto',
    pendekatan: 'Kunjungan Rumah',
    deskripsi:
        'Tindak lanjut perilaku agresif siswa yang dilaporkan oleh guru kelas.',
    evaluasi:
        'Orang tua akan bekerja sama dengan sekolah dalam program pembinaan perilaku siswa.',
    lampiranUrl: 'https://example.com/lampiran13.pdf',
  ),
  (
    id: 14,
    type: KonselingType.homeVisit,
    topik: 'Dukungan Keluarga',
    tanggal: 'Jumat, 6 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Dewi Lestari',
    pendekatan: 'Kunjungan Rumah',
    deskripsi:
        'Evaluasi tingkat dukungan keluarga terhadap pendidikan anak di sekolah.',
    evaluasi:
        'Disarankan orang tua aktif menghadiri pertemuan orang tua yang diselenggarakan sekolah.',
    lampiranUrl: null,
  ),
  (
    id: 15,
    type: KonselingType.homeVisit,
    topik: 'Kondisi Ekonomi Keluarga',
    tanggal: 'Selasa, 3 Juni 2025',
    durasiMenit: 60,
    namaGuru: 'Siti Rahayu',
    pendekatan: 'Kunjungan Rumah',
    deskripsi:
        'Verifikasi kondisi ekonomi keluarga sebagai dasar pertimbangan beasiswa sekolah.',
    evaluasi:
        'Data telah dikumpulkan dan akan diproses oleh tim beasiswa sekolah.',
    lampiranUrl: null,
  ),
];

@riverpod
class KonselingController extends _$KonselingController {
  @override
  List<KonselingEntity> build(KonselingType type) {
    return _mockKonseling
        .where((e) => e.type == type)
        .take(5)
        .map(
          (e) => KonselingEntity(
            id: e.id,
            type: e.type,
            topik: e.topik,
            tanggal: e.tanggal,
            durasiMenit: e.durasiMenit,
            namaGuru: e.namaGuru,
            pendekatan: e.pendekatan,
            deskripsi: e.deskripsi,
            evaluasi: e.evaluasi,
            lampiranUrl: e.lampiranUrl,
          ),
        )
        .toList();
  }
}

@riverpod
class DetailKonselingController extends _$DetailKonselingController {
  @override
  KonselingEntity build(int id) {
    final match = _mockKonseling.firstWhere(
      (e) => e.id == id,
      orElse: () => _mockKonseling.first,
    );
    return KonselingEntity(
      id: match.id,
      type: match.type,
      topik: match.topik,
      tanggal: match.tanggal,
      durasiMenit: match.durasiMenit,
      namaGuru: match.namaGuru,
      pendekatan: match.pendekatan,
      deskripsi: match.deskripsi,
      evaluasi: match.evaluasi,
      lampiranUrl: match.lampiranUrl,
    );
  }
}
