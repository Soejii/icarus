import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/core/domain/entities/task_entity.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:gaia/shared/utils/date_helper.dart';
import 'package:go_router/go_router.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.entity});
  final TaskEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 169, 15, 1),
            Color.fromRGBO(255, 191, 76, 1),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        boxShadow: context.brand.shadow,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64.h,
              height: 64.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(201, 238, 255, 1),
                    Color.fromRGBO(255, 255, 255, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SizedBox(
                  height: 56.h,
                  width: 56.h,
                  child: Image.asset(
                    AssetsHelper.imgTask,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    entity.subjectName ?? 'Mapel Tidak Ditemukan',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    entity.title ?? '---',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    formatIndoDate(entity.date),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            _circle(entity.status, context)
          ],
        ),
      ),
    );
  }

  Widget _circle(TaskStatus status, BuildContext context) {
    switch (status) {
      case TaskStatus.submitted:
        return Container(
          width: 64.h,
          height: 64.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 6.w),
            color: context.brand.green,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                '${entity.score ?? 0}',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      case TaskStatus.assigned:
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              RouteName.detailTask,
              pathParameters: {'id': entity.id.toString()},
            );
          },
          child: Container(
            width: 64.h,
            height: 64.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 6.w),
              color: context.brand.green,
            ),
            child: Center(
              child: Text(
                'Kerjakan',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      case TaskStatus.review:
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              RouteName.detailTask,
              pathParameters: {'id': entity.id.toString()},
            );
          },
          child: Container(
            width: 64.h,
            height: 64.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 6.w),
              color: const Color.fromRGBO(255, 122, 0, 1),
            ),
            child: Center(
              child: Text(
                'Review',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      default:
        return Container(
          width: 64.h,
          height: 64.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 6.w),
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              'ERROR',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        );
    }
  }
}
