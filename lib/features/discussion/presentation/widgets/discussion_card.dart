import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/discussion/domain/entity/poster_discussion_entity.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class DiscussionCard extends StatelessWidget {
  const DiscussionCard({
    super.key,
    required this.isDetail,
    required this.entity,
  });
  final bool isDetail;
  final PosterDiscussionEntity? entity;

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
                height: 42.h,
                width: 42.h,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                    entity?.posterPhoto ?? '',
                  ),
                  backgroundImage: AssetImage(
                    AssetsHelper.imgProfilePlaceholder,
                  ),
                ),
              ),
              SizedBox(width: 18.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entity?.posterName ?? '-',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: context.brand.textMain,
                    ),
                  ),
                  Text(
                    'Kelas: ${entity?.posterClass ?? '-'}',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.textMain,
                    ),
                  ),
                  Text(
                    entity?.posterDate ?? '-',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: context.brand.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            entity?.text ?? '-',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${entity?.likesCount ?? 0} Suka',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                '${entity?.commentCount ?? 0} Komentar',
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
          Container(
            width: double.infinity,
            height: 1.h,
            color: const Color.fromRGBO(37, 119, 195, 0.1),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: context.brand.inactive,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (!isDetail) {
                    context.pushNamed(
                      RouteName.detailDiscussion,
                      pathParameters: {'id': (entity?.id ?? 0).toString()},
                    );
                  }
                },
                icon: Icon(
                  Icons.comment,
                  color: context.brand.inactive,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.h,
            color: const Color.fromRGBO(37, 119, 195, 0.1),
          ),
        ],
      ),
    );
  }
}
