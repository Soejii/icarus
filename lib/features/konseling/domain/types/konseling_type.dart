enum KonselingType {
  student,
  parent,
  homeVisit,
}

extension KonselingTypeDisplay on KonselingType {
  String get displayName => switch (this) {
        KonselingType.student => 'Siswa',
        KonselingType.parent => 'Orang Tua',
        KonselingType.homeVisit => 'Home Visit',
      };

  String get apiValue => switch (this) {
        KonselingType.student => 'student',
        KonselingType.parent => 'parent',
        KonselingType.homeVisit => 'home_visit',
      };
}

const konselingTypes = [
  KonselingType.student,
  KonselingType.parent,
  KonselingType.homeVisit,
];
