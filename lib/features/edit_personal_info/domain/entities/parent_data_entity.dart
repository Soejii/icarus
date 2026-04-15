enum Kewarganegaraan { indonesia, lainnya }

class ParentDataEntity {
  final String? nik;
  final String? namaLengkap;
  final String? tempatLahir;
  final DateTime? tanggalLahir;
  final Kewarganegaraan kewarganegaraan;
  final String? kewarganegaraanLain;
  final String? agama;
  final String? alamat;
  final String? pendidikan;
  final String? pekerjaan;
  final String? tempatKerja;
  final String? penghasilan;
  final String? noTelepon;
  final String? email;
  final bool berkebutuhanKhusus;

  ParentDataEntity({
    this.nik,
    this.namaLengkap,
    this.tempatLahir,
    this.tanggalLahir,
    this.kewarganegaraan = Kewarganegaraan.indonesia,
    this.kewarganegaraanLain,
    this.agama,
    this.alamat,
    this.pendidikan,
    this.pekerjaan,
    this.tempatKerja,
    this.penghasilan,
    this.noTelepon,
    this.email,
    this.berkebutuhanKhusus = false,
  });
}
