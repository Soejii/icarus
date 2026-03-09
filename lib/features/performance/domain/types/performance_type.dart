import 'package:icarus/shared/core/constant/assets_helper.dart';

enum PerformanceType {
  exam,
  quiz,
  cbt,
  studentNotes,
  classNotes,
}

extension GetEdutainmentType on PerformanceType {
  String get name => switch (this) {
        PerformanceType.exam => 'Latihan Soal',
        PerformanceType.quiz => 'Quiz',
        PerformanceType.cbt => 'CBT',
        PerformanceType.studentNotes => 'Catatan Siswa',
        PerformanceType.classNotes => 'Catatan Kelas',
      };
}

extension GetPerformanceTypeIcon on PerformanceType {
  String get asset => switch (this) {
        PerformanceType.exam => AssetsHelper.imgExamPerformanceCard,
        PerformanceType.quiz => AssetsHelper.imgQuizPerformanceCard,
        PerformanceType.cbt => AssetsHelper.imgCbtPerformanceCard,
        PerformanceType.studentNotes => AssetsHelper.imgNotePerformanceCard,
        PerformanceType.classNotes => AssetsHelper.imgNotePerformanceCard,
      };
}

const performanceTypes = [
  PerformanceType.exam,
  PerformanceType.quiz,
  PerformanceType.cbt,
  PerformanceType.studentNotes,
  PerformanceType.classNotes,
];
