class TahfidzRecord {
  final int id;
  final String date;
  final String monthLabel;
  final String className;
  final String teacher;
  final String ziyadahSurah;
  final String ziyadahAyat;
  final String ziyadahScore;
  final String murajaahSurah;
  final String murajaahAyat;
  final String murajaahScore;
  final String catatan;

  const TahfidzRecord({
    required this.id,
    required this.date,
    required this.monthLabel,
    required this.className,
    required this.teacher,
    required this.ziyadahSurah,
    required this.ziyadahAyat,
    required this.ziyadahScore,
    required this.murajaahSurah,
    required this.murajaahAyat,
    required this.murajaahScore,
    this.catatan = '',
  });
}

class TahsinRecord {
  final int id;
  final String date;
  final String monthLabel;
  final String className;
  final String teacher;
  final String hafalanSurah;
  final String hafalanAyat;
  final String hafalanScore;
  final String ummiSurah;
  final String ummiAyat;
  final String ummiScore;
  final String catatan;

  const TahsinRecord({
    required this.id,
    required this.date,
    required this.monthLabel,
    required this.className,
    required this.teacher,
    required this.hafalanSurah,
    required this.hafalanAyat,
    required this.hafalanScore,
    required this.ummiSurah,
    required this.ummiAyat,
    required this.ummiScore,
    this.catatan = '',
  });
}
