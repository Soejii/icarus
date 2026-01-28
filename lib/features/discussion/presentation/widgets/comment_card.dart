import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/discussion/domain/entity/comment_entity.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.entity});
  final CommentEntity? entity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32.h,
                width: 32.h,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                    entity?.posterPhoto ?? '',
                  ),
                  backgroundImage: AssetImage(
                    AssetsHelper.imgProfilePlaceholder,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                entity?.posterName ?? '-',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
              SizedBox(width: 7.w),
              Container(
                width: 3.h,
                height: 3.h,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.brand.textSecondary,
                ),
              ),
              SizedBox(width: 7.w),
              Text(
                entity?.posterDate ?? '-',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.w, right: 20.w),
            child: Text(
              entity?.text ?? '',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: context.brand.textMain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
