import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/domain/entities/change_request_entity.dart';
import 'package:icarus/shared/core/constant/app_colors.dart';

class ChangeHistoryCardWidget extends StatelessWidget {
  final ChangeRequestEntity entity;

  const ChangeHistoryCardWidget({super.key, required this.entity});

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        statusBadge(context),
                        Text(
                          _formatDate(entity.requestDate),
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: context.brand.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diperbarui',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: context.brand.textSecondary,
                          ),
                        ),
                        Text(
                          _formatDate(entity.updatedAt),
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: context.brand.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  statusBadge(BuildContext context) {
    final label = switch (entity.status) {
      ChangeRequestStatus.approved => 'Disetujui',
      ChangeRequestStatus.rejected => 'Ditolak',
      ChangeRequestStatus.pending => 'Menunggu',
    };

    if (entity.status == ChangeRequestStatus.approved) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: context.brand.mainGradient,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    final badgeColor = entity.status == ChangeRequestStatus.rejected
        ? AppColors.danger
        : AppColors.warning;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
