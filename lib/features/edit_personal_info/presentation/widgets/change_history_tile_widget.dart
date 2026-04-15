import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/edit_personal_info/domain/entities/change_request_entity.dart';
import 'package:icarus/shared/core/constant/app_colors.dart';

class ChangeHistoryTileWidget extends StatelessWidget {
  final ChangeRequestEntity entity;

  const ChangeHistoryTileWidget({super.key, required this.entity});

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${_months[date.month - 1]} ${date.year}\n$h:$m WIB';
  }

  Color _badgeColor(BuildContext context) {
    return switch (entity.status) {
      ChangeRequestStatus.disetujui => context.brand.success,
      ChangeRequestStatus.ditolak => AppColors.danger,
      ChangeRequestStatus.menunggu => AppColors.warning,
    };
  }

  String _badgeLabel() {
    return switch (entity.status) {
      ChangeRequestStatus.disetujui => 'Disetujui',
      ChangeRequestStatus.ditolak => 'Ditolak',
      ChangeRequestStatus.menunggu => 'Menunggu',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(entity.tanggalPermintaan),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: context.brand.textMain,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(entity.tanggalUpdate),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: context.brand.textMain,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _badgeColor(context),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  _badgeLabel(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
