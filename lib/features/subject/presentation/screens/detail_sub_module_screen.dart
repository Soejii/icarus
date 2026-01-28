import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/features/subject/presentation/providers/detail_sub_module_controller.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/utils/date_helper.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailSubModuleScreen extends HookConsumerWidget {
  const DetailSubModuleScreen({super.key, required this.idSubModule});
  final int idSubModule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfController = useMemoized(() => PdfViewerController());
    final asyncDetail =
        ref.watch(detailSubModuleControllerProvider(idSubModule));
    final link = asyncDetail.valueOrNull?.link;

    Future<void> downloadPdf() async {
      final controller =
          ref.read(detailSubModuleControllerProvider(idSubModule).notifier);
      final success = await controller.downloadPdf(pdfController);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF saved successfully')),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(
        title: 'Detail Sub Modul',
        leadingIcon: true,
        actions: link != null
            ? [
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.white),
                  onPressed: downloadPdf,
                ),
              ]
            : null,
      ),
      body: asyncDetail.when(
        data: (data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                data.title ?? '-',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: context.brand.textMain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                formatIndoDate(data.date),
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: context.brand.textSecondary,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            if (data.link != null)
              Expanded(
                child: SfPdfViewer.network(
                  data.link!,
                  controller: pdfController,
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Html(
                      data: data.data ?? '',
                      style: {
                        "body": Style(
                          color: context.brand.textMain,
                          fontFamily: "Open Sans",
                          fontSize: FontSize(14.sp),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          lineHeight: LineHeight.normal,
                        ),
                        "h1": Style(
                            fontSize: FontSize(22.sp),
                            fontWeight: FontWeight.bold),
                        "h2": Style(
                            fontSize: FontSize(20.sp),
                            fontWeight: FontWeight.bold),
                        "h3": Style(
                            fontSize: FontSize(18.sp),
                            fontWeight: FontWeight.w600),
                        "p": Style(margin: Margins.zero),
                        "ul": Style(
                            margin: Margins.zero, padding: HtmlPaddings.zero),
                        "li": Style(margin: Margins.zero),
                        "strong": Style(fontWeight: FontWeight.w600),
                        "em": Style(fontStyle: FontStyle.italic),
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () =>
              ref.invalidate(detailSubModuleControllerProvider(idSubModule)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
