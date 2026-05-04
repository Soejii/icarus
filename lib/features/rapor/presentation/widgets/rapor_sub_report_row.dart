import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_detail_report_entity.dart';
import 'package:icarus/features/rapor/presentation/screens/rapor_pdf_viewer_args.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';

class RaporSubReportRow extends ConsumerWidget {
  const RaporSubReportRow({super.key, required this.detail});

  final RaporDetailReportEntity detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: detail.hasFile ? () => openPdf(context) : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 12.w, 10.h),
        child: Row(
          children: [
            Icon(
              Icons.description_rounded,
              size: 16.r,
              color: context.brand.primary,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                detail.displayName,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            detail.hasFile ? seePill(context) : missingFileTag(context),
          ],
        ),
      ),
    );
  }

  Widget seePill(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.brand.mainGradient,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(1.5.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: GradientText(
          'Lihat',
          gradient: context.brand.mainGradient,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget missingFileTag(BuildContext context) {
    return Text(
      'Tidak tersedia',
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: context.brand.inactive,
      ),
    );
  }

  void openPdf(BuildContext context) {
    context.pushNamed(
      RouteName.raporPdfViewer,
      extra: RaporPdfViewerArgs(
        fileUrl: detail.fileUrl!,
        suggestedFileName: detail.displayName.endsWith('.pdf')
            ? detail.displayName
            : '${detail.displayName}.pdf',
      ),
    );
  }
}
