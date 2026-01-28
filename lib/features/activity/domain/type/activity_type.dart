enum ActivityType {
  exam,
  quiz,
  cbt,
  task,
}

extension GetEdutainmentType on ActivityType {
  String get name => switch (this) {
        ActivityType.exam => 'Latihan Soal',
        ActivityType.quiz => 'Quiz',
        ActivityType.cbt => 'CBT',
        ActivityType.task => 'Tugas'
      };
}

const activityTypes = [
  ActivityType.exam,
  ActivityType.quiz,
  ActivityType.cbt,
  ActivityType.task,
];
