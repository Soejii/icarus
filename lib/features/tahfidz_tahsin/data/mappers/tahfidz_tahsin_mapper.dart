import 'package:intl/intl.dart';
import 'package:icarus/features/tahfidz_tahsin/data/models/tahfidz_tahsin_model.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/shared/utils/date_helper.dart';

extension TahfidzMapper on TahfidzModel {
  TahfidzRecord toEntity() => TahfidzRecord(
        id: id,
        date: formatIndoDate(date),
        monthLabel: _formatMonthLabel(date),
        className: rombel?.name ?? '-',
        teacher: teacher?.name ?? '-',
        ziyadahSurah: additionSurah ?? '-',
        ziyadahAyat: additionVerse ?? '-',
        ziyadahScore: additionScore ?? '-',
        murajaahSurah: reviewSurah ?? '-',
        murajaahAyat: reviewVerse ?? '-',
        murajaahScore: reviewScore ?? '-',
        catatan: notes ?? '-',
      );
}

extension TahsinMapper on TahsinModel {
  TahsinRecord toEntity() => TahsinRecord(
        id: id,
        date: formatIndoDate(date),
        monthLabel: _formatMonthLabel(date),
        className: rombel?.name ?? '-',
        teacher: teacher?.name ?? '-',
        hafalanSurah: memorizationSurah ?? '-',
        hafalanAyat: memorizationVerse ?? '-',
        hafalanScore: memorizationScore ?? '-',
        ummiSurah: ummiQuran ?? '-',
        ummiAyat: ummiQuranVerse ?? '-',
        ummiScore: ummiQuranScore ?? '-',
        catatan: notes ?? '-',
      );
}

String _formatMonthLabel(String? dateStr) {
  try {
    return DateFormat.yMMMM('id_ID').format(DateTime.parse(dateStr ?? ''));
  } catch (_) {
    return '-';
  }
}
