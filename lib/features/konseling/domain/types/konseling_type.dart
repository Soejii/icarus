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

  String get apiValue => switch (this) {
        KonselingType.siswa => 'student',
        KonselingType.orangTua => 'parent',
        KonselingType.homeVisit => 'home_visit',
      };
}

const konselingTypes = [
  KonselingType.siswa,
  KonselingType.orangTua,
  KonselingType.homeVisit,
];
