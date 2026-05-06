import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/domain/types/daily_note_type.dart';
import 'package:icarus/shared/core/constant/assets_helper.dart';
import 'package:icarus/shared/utils/date_helper.dart';

class DailyNoteCard extends StatelessWidget {
  const DailyNoteCard({
    super.key,
    required this.entity,
    required this.kind,
    required this.onTap,
  });

  final NoteEntity entity;
  final DailyNoteType kind;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: const Color.fromRGBO(0, 0, 0, 0.10),
              width: 1.w,
            ),
            bottom: BorderSide(
              color: const Color.fromRGBO(0, 0, 0, 0.10),
              width: 1.w,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 32.w,
                height: 32.h,
                child: Image.asset(AssetsHelper.imgNotePerformanceCard),
              ),
              SizedBox(width: 20.w),
              Expanded(child: noteContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget noteContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (entity.title ?? '').toUpperCase(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: context.brand.textMain,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.person_outline,
              size: 14.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.50),
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                entity.teacherName ?? '-',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 0.50),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Icon(
              Icons.calendar_today_outlined,
              size: 12.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.50),
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                formatIndoDate(entity.date ?? ''),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 0.50),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          entity.note ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textMain,
          ),
        ),
        if (kind == DailyNoteType.classRoom &&
            (entity.place?.isNotEmpty == true ||
                entity.clock?.isNotEmpty == true)) ...[
          SizedBox(height: 6.h),
          classNoteMetaRow(context),
        ],
      ],
    );
  }

  Widget classNoteMetaRow(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: [
        if (entity.place?.isNotEmpty == true)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 12.sp,
                  color: context.brand.textSecondary,
                ),
                SizedBox(width: 2.w),
                Text(
                  entity.place!,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        if (entity.clock?.isNotEmpty == true)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 12.sp,
                  color: context.brand.textSecondary,
                ),
                SizedBox(width: 2.w),
                Text(
                  entity.clock!,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: context.brand.textSecondary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
