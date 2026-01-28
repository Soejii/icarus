import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/task/domain/entities/detail_task_entity.dart';
import 'package:intl/intl.dart';

class DetailTaskHeaderWidget extends StatelessWidget {
  const DetailTaskHeaderWidget({super.key, required this.entity});
  final DetailTaskEntity entity;

  @override
  Widget build(BuildContext context) {
    String formatDate(String? dateStr) {
      try {
        final formatter = DateFormat('d MMMM yyyy, HH:mm', 'id_ID');
        return formatter.format(DateTime.parse(dateStr ?? ''));
      } catch (_) {
        return 'Batas Pengumpulan Tidak Ditemukan';
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: context.brand.shadow,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoCard(
              Icons.calendar_month_rounded,
              'Batas Pengumpulan',
              formatDate(entity.finishAt),
              context,
            ),
            SizedBox(height: 8.h),
            infoCard(
              Icons.assignment_outlined,
              'Judul Tugas',
              entity.title ?? '-',
              context,
            ),
            SizedBox(height: 8.h),
            infoCard(
              Icons.person,
              'Guru Pengajar',
              entity.teacherName ?? '-',
              context,
            ),
          ],
        ),
      ),
    );
  }

  infoCard(
    IconData icon,
    String title,
    String value,
    BuildContext context,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: context.brand.inactive,
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: context.brand.textMain,
              ),
            ),
          ],
        ),
        SizedBox(width: 40.w),
        Flexible(
          child: Text(
            value,
            maxLines: 2,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: context.brand.primary,
            ),
          ),
        ),
      ],
    );
  }
}
