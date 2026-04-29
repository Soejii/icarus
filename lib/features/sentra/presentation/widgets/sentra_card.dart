import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/sentra/domain/entities/sentra_entity.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';

class SentraCard extends StatelessWidget {
  const SentraCard({super.key, required this.entity});

  final SentraEntity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        RouteName.sentraDetail,
        pathParameters: {'id': entity.id.toString()},
        extra: entity,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: context.brand.shadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entity.name,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: context.brand.textMain,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.event_outlined,
                        size: 14.sp,
                        color: context.brand.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        entity.date,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: context.brand.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.school_outlined,
                        size: 14.sp,
                        color: context.brand.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          entity.classGroup,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: context.brand.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            scoreChip(context, entity.score),
          ],
        ),
      ),
    );
  }

  scoreChip(BuildContext context, int score) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: context.brand.green,
        borderRadius: BorderRadius.circular(16.r),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            score.toString(),
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Nilai',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
