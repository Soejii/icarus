import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/konseling/domain/entities/konseling_entity.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';

class KonselingCard extends StatelessWidget {
  const KonselingCard({super.key, required this.entity});

  final KonselingEntity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        RouteName.konselingDetail,
        pathParameters: {'id': entity.id.toString()},
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: context.brand.shadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                pendekatanChip(context, entity.pendekatan),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  size: 20.sp,
                  color: context.brand.textSecondary,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              entity.topik,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: context.brand.textMain,
                height: 1.3,
              ),
            ),
            SizedBox(height: 12.h),
            Container(height: 1.h, color: context.brand.inactive),
            SizedBox(height: 12.h),
            Row(
              children: [
                metaIcon(context, Icons.event_outlined, entity.tanggal),
                SizedBox(width: 16.w),
                metaIcon(
                  context,
                  Icons.access_time_outlined,
                  '${entity.durasiMenit} Menit',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pendekatanChip(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.brand.green,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  metaIcon(BuildContext context, IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: context.brand.textSecondary),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: context.brand.textSecondary,
          ),
        ),
      ],
    );
  }
}
