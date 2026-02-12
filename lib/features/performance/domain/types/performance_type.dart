enum PerformanceType {
  exam,
  quiz,
  cbt,
  studentNotes,
}

extension GetEdutainmentType on PerformanceType {
  String get name => switch (this) {
        PerformanceType.exam => 'Latihan Soal',
        PerformanceType.quiz => 'Quiz',
        PerformanceType.cbt => 'CBT',
        PerformanceType.studentNotes => 'Catatan Siswa'
      };
}

const performanceTypes = [
  PerformanceType.exam,
  PerformanceType.quiz,
  PerformanceType.cbt,
  PerformanceType.studentNotes,
];
