import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';

class TahfidzDetailSheet extends StatelessWidget {
  const TahfidzDetailSheet({super.key, required this.record});
  final TahfidzRecord record;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TAHFIDZ',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  size: 20.r,
                  color: context.brand.textMain,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _Divider(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                record.date,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  color: context.brand.textSecondary,
                ),
              ),
              Text(
                record.className,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  color: context.brand.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _Divider(),
          SizedBox(height: 16.h),
          Text(
            'Guru: ${record.teacher}',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          _Divider(),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _DetailColumn(
                  label: 'ZIYADAH SURAT',
                  surah: record.ziyadahSurah,
                  ayat: record.ziyadahAyat,
                  score: record.ziyadahScore,
                  labelColor: context.brand.textMain,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _DetailColumn(
                  label: 'MURAJAAH SURAT',
                  surah: record.murajaahSurah,
                  ayat: record.murajaahAyat,
                  score: record.murajaahScore,
                  labelColor: context.brand.textMain,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _Divider(),
          SizedBox(height: 16.h),
          Text(
            'CATATAN',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            constraints: BoxConstraints(minHeight: 80.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: context.brand.inactive.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              record.catatan,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                color: context.brand.textMain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.brand.inactive.withOpacity(0.3),
      height: 1,
      thickness: 1,
    );
  }
}

class _DetailColumn extends StatelessWidget {
  const _DetailColumn({
    required this.label,
    required this.surah,
    required this.ayat,
    required this.score,
    required this.labelColor,
  });

  final String label;
  final String surah;
  final String ayat;
  final String score;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: labelColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          surah,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            color: context.brand.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          ayat,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            color: context.brand.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        _ScorePill(score: score),
      ],
    );
  }
}

class _ScorePill extends StatelessWidget {
  const _ScorePill({required this.score});
  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.brand.success,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        score,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
