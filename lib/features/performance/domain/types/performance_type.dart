import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:icarus/shared/core/domain/types/exam_type.dart';

enum PerformanceType {
  exam,
  quiz,
  cbt,
  studentNotes,
  classNotes,
  unknown,
}

extension GetEdutainmentType on PerformanceType {
  String get name => switch (this) {
        PerformanceType.exam => 'Latihan Soal',
        PerformanceType.quiz => 'Quiz',
        PerformanceType.cbt => 'CBT',
        PerformanceType.studentNotes => 'Catatan Siswa',
        PerformanceType.classNotes => 'Catatan Kelas',
        PerformanceType.unknown => 'Error',
      };
}

extension GetPerformanceTypeIcon on PerformanceType {
  String get asset => switch (this) {
        PerformanceType.exam => AssetsHelper.imgExamPerformanceCard,
        PerformanceType.quiz => AssetsHelper.imgQuizPerformanceCard,
        PerformanceType.cbt => AssetsHelper.imgCbtPerformanceCard,
        PerformanceType.studentNotes => AssetsHelper.imgNotePerformanceCard,
        PerformanceType.classNotes => AssetsHelper.imgNotePerformanceCard,
        PerformanceType.unknown => AssetsHelper.imgUnknownError,
      };
}

extension PerformanceTypeToExamType on PerformanceType {
  ExamType get changeToExamType => switch (this) {
        PerformanceType.exam => ExamType.exam,
        PerformanceType.quiz => ExamType.quiz,
        PerformanceType.cbt => ExamType.cbt,
        PerformanceType.studentNotes => ExamType.unkown,
        PerformanceType.classNotes => ExamType.unkown,
        PerformanceType.unknown => ExamType.unkown,
      };
}

const performanceTypes = [
  PerformanceType.exam,
  PerformanceType.quiz,
  PerformanceType.cbt,
  PerformanceType.studentNotes,
  PerformanceType.classNotes,
];
