class HomeBillEntity {
  final String studentName;
  final String studentNis;
  final String studentClass;
  final int unpaidTotal;
  final int unpaidSpp;
  final int unpaidDpp;
  final int unpaidLainnya;
  final String? info;

  HomeBillEntity({
    required this.studentName,
    required this.studentNis,
    required this.studentClass,
    required this.unpaidTotal,
    required this.unpaidSpp,
    required this.unpaidDpp,
    required this.unpaidLainnya,
    required this.info,
  });
}
