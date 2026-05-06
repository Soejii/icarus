import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AttachmentPreviewSheet extends StatelessWidget {
  const AttachmentPreviewSheet({super.key, required this.fileUrl});

  final String fileUrl;

  bool get isPdf =>
      fileUrl.toLowerCase().contains('.pdf') ||
      fileUrl.toLowerCase().contains('pdf');

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.85),
      child: Stack(
        alignment: Alignment.center,
        children: [
          isPdf ? pdfPreview(context) : imagePreview(context),
          Positioned(
            top: 48.h,
            right: 16.w,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close, color: Colors.white, size: 28.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget imagePreview(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              fileUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.broken_image_outlined,
                color: Colors.white,
                size: 64.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        downloadButton(),
      ],
    );
  }

  Widget pdfPreview(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.picture_as_pdf, color: Colors.white, size: 80.sp),
        SizedBox(height: 16.h),
        Text(
          'Dokumen PDF',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 24.h),
        openPdfButton(),
      ],
    );
  }

  Widget downloadButton() {
    return GestureDetector(
      onTap: launchFileUrl,
      child: Text(
        'Download',
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          decoration: TextDecoration.underline,
          decorationColor: Colors.white,
        ),
      ),
    );
  }

  Widget openPdfButton() {
    return GestureDetector(
      onTap: launchFileUrl,
      child: Text(
        'Lihat PDF',
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          decoration: TextDecoration.underline,
          decorationColor: Colors.white,
        ),
      ),
    );
  }

  Future<void> launchFileUrl() async {
    await launchUrl(Uri.parse(fileUrl), mode: LaunchMode.externalApplication);
  }
}
