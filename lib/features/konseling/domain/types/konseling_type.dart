enum KonselingType {
  siswa,
  orangTua,
  homeVisit,
}

extension KonselingTypeDisplay on KonselingType {
  String get displayName => switch (this) {
        KonselingType.siswa => 'Siswa',
        KonselingType.orangTua => 'Orang Tua',
        KonselingType.homeVisit => 'Home Visit',
      };
}

const konselingTypes = [
  KonselingType.siswa,
  KonselingType.orangTua,
  KonselingType.homeVisit,
];
