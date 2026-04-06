import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/schedule/domain/entities/schedule_entity.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.entity});

  final ScheduleEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: context.brand.shadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          accentBar(context),
          SizedBox(width: 24.w),
          timeSection(context),
          SizedBox(width: 24.w),
          Expanded(child: infoSection(context)),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }

  accentBar(BuildContext context) {
    return Container(
      width: 8.w,
      decoration: BoxDecoration(
        gradient: context.brand.mainGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          bottomLeft: Radius.circular(15.r),
        ),
      ),
    );
  }

  timeSection(BuildContext context) {
    final style = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );
    return SizedBox(
      width: 86.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientText(
            _formatTime(entity.startTime),
            gradient: context.brand.mainGradient,
            style: style,
          ),
          GradientText(
            '-',
            gradient: context.brand.mainGradient,
            style: style,
          ),
          GradientText(
            _formatTime(entity.endTime),
            gradient: context.brand.mainGradient,
            style: style,
          ),
        ],
      ),
    );
  }

  infoSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoRow(context, label: 'Subject :', value: entity.subjectName),
          SizedBox(height: 4.h),
          infoRow(
            context,
            label: 'Guru Pengajar :',
            value: entity.teacherName,
          ),
        ],
      ),
    );
  }

  infoRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 2.h),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: context.brand.textMain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Converts "07:00:00" → "07.00 WIB"
  String _formatTime(String raw) {
    final parts = raw.split(':');
    if (parts.length < 2) return raw;
    return '${parts[0]}.${parts[1]}';
  }
}
