import 'package:icarus/shared/core/constant/assets_helper.dart';


enum ExamType {
  exam,
  quiz,
  cbt,
  unkown,
}

extension ExamTypeName on ExamType {
  String get realName => switch (this) {
        ExamType.exam => 'Latihan Soal',
        ExamType.quiz => 'Quiz',
        ExamType.cbt => 'CBT',
        ExamType.unkown => 'Errorr',
      };
}

extension GetIcon on ExamType {
  String get asset => switch (this) {
        ExamType.exam => AssetsHelper.imgExamPerformanceCard,
        ExamType.quiz => AssetsHelper.imgQuizPerformanceCard,
        ExamType.cbt => AssetsHelper.imgCbtPerformanceCard,
        ExamType.unkown => AssetsHelper.imgUnknownError,
      };
}

const examTypes = [
  ExamType.exam,
  ExamType.quiz,
  ExamType.cbt,
];
