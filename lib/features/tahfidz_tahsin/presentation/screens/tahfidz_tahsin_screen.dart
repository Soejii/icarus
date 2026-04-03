import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/providers/tahfidz_tahsin_providers.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/widgets/tahfidz_record_card.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/widgets/tahfidz_tahsin_tab_toggle.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/widgets/tahsin_record_card.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

const _tahfidzRecords = [
  TahfidzRecord(
    date: 'Senin, 31 Maret 2025',
    monthLabel: 'Maret 2025',
    className: 'XII-A',
    teacher: 'BAMBANG',
    ziyadahSurah: 'Al-Fatihah',
    ziyadahAyat: 'Ayat 1',
    ziyadahScore: '100',
    murajaahSurah: 'Al-Baqarah',
    murajaahAyat: 'Ayat 1',
    murajaahScore: 'Baik',
  ),
  TahfidzRecord(
    date: 'Rabu, 12 Maret 2025',
    monthLabel: 'Maret 2025',
    className: 'XII-A',
    teacher: 'BAMBANG',
    ziyadahSurah: 'Al-Baqarah',
    ziyadahAyat: 'Ayat 1–5',
    ziyadahScore: '90',
    murajaahSurah: 'An-Nas',
    murajaahAyat: 'Ayat 1',
    murajaahScore: '85',
  ),
  TahfidzRecord(
    date: 'Jumat, 28 Februari 2025',
    monthLabel: 'Februari 2025',
    className: 'XII-A',
    teacher: 'BAMBANG',
    ziyadahSurah: 'Al-Fatihah',
    ziyadahAyat: 'Ayat 1',
    ziyadahScore: '100',
    murajaahSurah: 'Al-Baqarah',
    murajaahAyat: 'Ayat 1',
    murajaahScore: 'Baik',
  ),
  TahfidzRecord(
    date: 'Jumat, 31 Januari 2025',
    monthLabel: 'Januari 2025',
    className: 'XII-A',
    teacher: 'BAMBANG',
    ziyadahSurah: 'Al-Fatihah',
    ziyadahAyat: 'Ayat 1',
    ziyadahScore: '100',
    murajaahSurah: 'Al-Baqarah',
    murajaahAyat: 'Ayat 1',
    murajaahScore: 'Baik',
  ),
];

const _tahsinRecords = [
  TahsinRecord(
    date: 'Senin, 31 Maret 2025',
    monthLabel: 'Maret 2025',
    className: 'XII-A',
    teacher: 'BAMBANG',
    hafalanSurah: 'Al-Fatihah',
    hafalanAyat: 'Ayat 1',
    hafalanScore: '100',
    ummiSurah: 'Al-Baqarah',
    ummiAyat: 'Ayat 1',
    ummiScore: 'Baik',
  ),
  TahsinRecord(
    date: 'Rabu, 12 Maret 2025',
    monthLabel: 'Maret 2025',
    className: 'XII-A',
    teacher: 'BAMBANG',
    hafalanSurah: 'Al-Baqarah',
    hafalanAyat: 'Ayat 1–5',
    hafalanScore: '90',
    ummiSurah: 'An-Nas',
    ummiAyat: 'Ayat 1',
    ummiScore: '85',
  ),
  TahsinRecord(
    date: 'Jumat, 28 Februari 2025',
    monthLabel: 'Februari 2025',
    className: 'XII-A',
    teacher: 'BAMBANG',
    hafalanSurah: 'Al-Fatihah',
    hafalanAyat: 'Ayat 1',
    hafalanScore: '100',
    ummiSurah: 'Al-Baqarah',
    ummiAyat: 'Ayat 1',
    ummiScore: 'Baik',
  ),
];

class TahfidzTahsinScreen extends ConsumerWidget {
  const TahfidzTahsinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tahfidzTahsinTabIndexProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Tahfidz/Tahsin',
        leadingIcon: true,
      ),
      body: Column(
        children: [
          const TahfidzTahsinTabToggle(),
          Expanded(
            child: tabIndex == 0 ? tahfidzList(context) : tahsinList(context),
          ),
        ],
      ),
    );
  }

  monthHeader(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 4.h),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: context.brand.textSecondary,
        ),
      ),
    );
  }

  tahfidzList(BuildContext context) {
    String? currentMonth;
    return ListView(
      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
      children: [
        for (final record in _tahfidzRecords) ...[
          if (record.monthLabel != currentMonth)
            monthHeader(context, currentMonth = record.monthLabel),
          TahfidzRecordCard(record: record),
        ],
      ],
    );
  }

  tahsinList(BuildContext context) {
    String? currentMonth;
    return ListView(
      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
      children: [
        for (final record in _tahsinRecords) ...[
          if (record.monthLabel != currentMonth)
            monthHeader(context, currentMonth = record.monthLabel),
          TahsinRecordCard(record: record),
        ],
      ],
    );
  }
}
