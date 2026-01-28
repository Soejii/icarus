import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/announcement/domain/entites/announcement_entity.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:go_router/go_router.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.entity});
  final AnnouncementEntity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'detail-announcement',
          pathParameters: {'id': entity.id.toString()},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: context.brand.shadow,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                entity.photo,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  AssetsHelper.imgAnnouncementPlaceholder,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200.h,
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.title,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: context.brand.textMain,
                      ),
                    ),
                    Text(
                      entity.date,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textMain,
                      ),
                    ),
                    Text(
                      entity.desc,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textSecondary,
                      ),
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
}
