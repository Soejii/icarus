import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/domain/entities/sub_module_entity.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class SubModuleCard extends StatelessWidget {
  const SubModuleCard({super.key, required this.entity});
  final SubModuleEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 24.w),
          SizedBox(
            height: 24.h,
            width: 24.h,
            child: Image.asset(
              entity.isUploaded
                  ? AssetsHelper.imgSubjectModulActive
                  : AssetsHelper.imgSubjectModulInactive,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              entity.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.brand.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () {
              if (entity.isUploaded) {
                context.pushNamed(
                  RouteName.detailSubModule,
                  pathParameters: {'id': entity.id.toString()},
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: entity.isUploaded
                    ? context.brand.green
                    : context.brand.inactive,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Text(
                  entity.isUploaded ? 'Telah Tayang' : 'Belum Tayang',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 9.sp,
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
