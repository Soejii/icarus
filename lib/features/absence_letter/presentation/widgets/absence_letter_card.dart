import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class AbsenceLetterCard extends StatelessWidget {
  const AbsenceLetterCard({super.key, required this.entity});

  final AbsenceLetterEntity entity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => viewAttachment(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: context.brand.shadow,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4.w,
                decoration: BoxDecoration(
                  gradient: context.brand.mainGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      typeBadge(context),
                      SizedBox(height: 4.h),
                      Text(
                        entity.date,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 11.sp,
                          color: context.brand.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        entity.description,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          color: context.brand.primary,
                        ),
                      ),
                      if (entity.evidencePath == null) ...[
                        SizedBox(height: 6.h),
                        Text(
                          'Tidak ada lampiran',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 11.sp,
                            color: context.brand.inactive,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (entity.evidencePath != null)
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Center(
                    child: Icon(
                      Icons.attach_file_rounded,
                      color: context.brand.primary,
                      size: 18.r,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  typeBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        gradient: context.brand.mainGradient,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        entity.type,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> viewAttachment(BuildContext context) async {
    final evidencePath = entity.evidencePath;
    if (evidencePath == null || evidencePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Surat izin ini tidak memiliki lampiran')),
      );
      return;
    }
    final uri = Uri.tryParse(evidencePath);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lampiran tidak dapat dibuka')),
      );
      return;
    }
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lampiran tidak dapat dibuka')),
      );
    }
  }
}
