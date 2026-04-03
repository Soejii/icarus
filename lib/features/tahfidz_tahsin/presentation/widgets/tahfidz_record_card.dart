import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/tahfidz_tahsin/domain/entities/tahfidz_tahsin_entity.dart';
import 'package:icarus/features/tahfidz_tahsin/presentation/widgets/tahfidz_detail_sheet.dart';

class TahfidzRecordCard extends StatelessWidget {
  const TahfidzRecordCard({super.key, required this.record});
  final TahfidzRecord record;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        builder: (_) => SingleChildScrollView(
          child: TahfidzDetailSheet(record: record),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: context.brand.shadow,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ziyadah: ${record.ziyadahSurah}',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: context.brand.primary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Murajaah: ${record.murajaahSurah}',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: context.brand.primary,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            record.date,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 11.sp,
                              color: context.brand.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        scoreBadge(context, record.ziyadahScore),
                        SizedBox(height: 4.h),
                        scoreBadge(context, record.murajaahScore),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
  scoreBadge(BuildContext context, String score) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.brand.success,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        score,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
