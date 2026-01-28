enum EdutainmentType {
  all,
  school,
  sidigs,
}

extension GetEdutainmentType on EdutainmentType {
  String get label => switch (this) {
        EdutainmentType.all => 'all',
        EdutainmentType.school => 'school',
        EdutainmentType.sidigs => 'sidigs'
      };
  String get name => switch (this) {
        EdutainmentType.all => 'Semua',
        EdutainmentType.school => 'Sekolah',
        EdutainmentType.sidigs => 'SIDIGS'
      };
}

const edutainmentTypes = [
  EdutainmentType.all,
  EdutainmentType.school,
  EdutainmentType.sidigs,
];
