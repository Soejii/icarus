import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/rapor/domain/entities/rapor_period_entity.dart';
import 'package:icarus/features/rapor/presentation/providers/rapor_expanded_periods_controller.dart';
import 'package:icarus/features/rapor/presentation/screens/rapor_pdf_viewer_args.dart';
import 'package:icarus/features/rapor/presentation/widgets/rapor_sub_report_row.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';

class RaporPeriodCard extends ConsumerWidget {
  const RaporPeriodCard({super.key, required this.period});

  final RaporPeriodEntity period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedIds = ref.watch(raporExpandedPeriodsProvider);
    final isExpanded = expandedIds.contains(period.id);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  headerWrapper(context, ref, isExpanded),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    child: expandedBody(context, isExpanded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWrapper(BuildContext context, WidgetRef ref, bool isExpanded) {
    final header = Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: headerContent(context, isExpanded),
    );

    if (period.isEmpty) return header;

    return InkWell(
      borderRadius: BorderRadius.only(topRight: Radius.circular(12.r)),
      onTap: () => onHeaderTap(context, ref),
      child: header,
    );
  }

  Widget headerContent(BuildContext context, bool isExpanded) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            gradient: context.brand.mainGradient,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 20.r,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                period.displayTitle,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: context.brand.textMain,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                period.displaySubtitle,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  color: context.brand.textSecondary,
                ),
              ),
            ],
          ),
        ),
        trailing(context, isExpanded),
      ],
    );
  }

  Widget trailing(BuildContext context, bool isExpanded) {
    if (period.isExpandable) {
      return AnimatedRotation(
        turns: isExpanded ? 0.25 : 0,
        duration: const Duration(milliseconds: 220),
        child: Icon(
          Icons.chevron_right_rounded,
          color: context.brand.textSecondary,
          size: 22.r,
        ),
      );
    }
    if (period.isFlatTappable) {
      return Icon(
        Icons.picture_as_pdf_rounded,
        color: context.brand.primary,
        size: 20.r,
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        'Belum ada dokumen',
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 10.sp,
          color: context.brand.inactive,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget expandedBody(BuildContext context, bool isExpanded) {
    if (!isExpanded || !period.isExpandable) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1.h,
          color: context.brand.inactive.withOpacity(0.15),
        ),
        ...period.detailReports.map(
          (detail) => RaporSubReportRow(detail: detail),
        ),
      ],
    );
  }

  void onHeaderTap(BuildContext context, WidgetRef ref) {
    if (period.isExpandable) {
      ref.read(raporExpandedPeriodsProvider.notifier).toggle(period.id);
      return;
    }
    if (!period.isFlatTappable) return;

    context.pushNamed(
      RouteName.raporPdfViewer,
      extra: RaporPdfViewerArgs(
        fileUrl: period.file!,
        suggestedFileName: '${period.displayTitle}.pdf',
      ),
    );
  }
}
