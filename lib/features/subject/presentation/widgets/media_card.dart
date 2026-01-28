import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/domain/entities/media_entity.dart';
import 'package:gaia/features/subject/presentation/mapper/media_ui_mapper.dart';
import 'package:gaia/shared/utils/date_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaCard extends StatelessWidget {
  const MediaCard({
    super.key,
    required this.entity,
  });
  final MediaEntity entity;

  Future<void> launchLink(String link) async {
    final uri = Uri.parse(link);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () async {
          if (entity.link != null) {
            await launchLink(entity.link!);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
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
              Container(
                height: 64.h,
                width: 64.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      entity.type.color,
                      const Color.fromRGBO(200, 238, 255, 0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 52.h,
                    width: 52.h,
                    child: Image.asset(entity.type.icon),
                  ),
                ),
              ),
              SizedBox(width: 17.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      entity.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: context.brand.textMain,
                      ),
                    ),
                    Text(
                      formatIndoDate(entity.date),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      ),
    );
  }
}
