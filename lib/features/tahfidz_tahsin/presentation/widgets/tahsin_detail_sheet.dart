import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';

class TahsinDetailSheet extends StatelessWidget {
  const TahsinDetailSheet({super.key, required this.record});
  final TahsinRecord record;

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
                'TAHSIN',
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
          divider(context),
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
          divider(context),
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
          divider(context),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: detailColumn(
                  context,
                  label: 'HAFALAN SURAT',
                  surah: record.hafalanSurah,
                  ayat: record.hafalanAyat,
                  score: record.hafalanScore,
                  labelColor: context.brand.textMain,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: detailColumn(
                  context,
                  label: 'UMMI / WAFA JILID/SURAT',
                  surah: record.ummiSurah,
                  ayat: record.ummiAyat,
                  score: record.ummiScore,
                  labelColor: context.brand.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          divider(context),
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

  divider(BuildContext context) {
    return Divider(
      color: context.brand.inactive.withOpacity(0.3),
      height: 1,
      thickness: 1,
    );
  }

  detailColumn(
    BuildContext context, {
    required String label,
    required String surah,
    required String ayat,
    required String score,
    required Color labelColor,
  }) {
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
        scorePill(context, score),
      ],
    );
  }

  scorePill(BuildContext context, String score) {
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
