import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/pusat_unduh/domain/entities/pusat_unduh_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class PusatUnduhCard extends StatelessWidget {
  const PusatUnduhCard({super.key, required this.entity});

  final PusatUnduhEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: context.brand.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.description_outlined,
                  size: 22.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: context.brand.textMain,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      entity.uploader,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: context.brand.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Container(height: 1.h, color: context.brand.inactive),
          SizedBox(height: 12.h),
          metaRow(
            context,
            Icons.event_available_outlined,
            'Mulai Terbit',
            entity.startDate,
          ),
          SizedBox(height: 6.h),
          metaRow(
            context,
            Icons.event_busy_outlined,
            'Selesai Terbit',
            entity.endDate,
          ),
          SizedBox(height: 14.h),
          downloadButton(context),
        ],
      ),
    );
  }

  metaRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: context.brand.textSecondary),
        SizedBox(width: 6.w),
        Text(
          '$label: ',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: context.brand.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textMain,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  downloadButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(entity.fileUrl),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: context.brand.green,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.download_outlined,
              size: 18.sp,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Text(
              'Unduh Lampiran',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
