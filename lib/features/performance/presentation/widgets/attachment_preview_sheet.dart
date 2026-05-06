import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:url_launcher/url_launcher.dart';

class AttachmentPreviewSheet extends StatelessWidget {
  const AttachmentPreviewSheet({super.key, required this.fileUrl});

  final String fileUrl;

  bool get isPdf =>
      Uri.parse(fileUrl).path.toLowerCase().endsWith('.pdf');

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: const Color.fromRGBO(10, 10, 10, 0.96),
      child: SafeArea(
        child: Column(
          children: [
            topBar(context),
            Expanded(
              child: isPdf ? pdfContent(context) : imageContent(context),
            ),
            bottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            'Lampiran',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.10),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.15),
                ),
              ),
              child: Text(
                isPdf ? 'PDF' : 'Gambar',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageContent(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              fileUrl,
              fit: BoxFit.contain,
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 240.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white54,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => SizedBox(
                height: 240.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white30,
                      size: 56.sp,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Gambar tidak dapat dimuat',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pdfContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.07),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: const Color.fromRGBO(255, 255, 255, 0.12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.picture_as_pdf_rounded,
                  color: Colors.white,
                  size: 38.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Dokumen PDF',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Buka dengan aplikasi PDF viewer',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 28.h),
      child: GestureDetector(
        onTap: launchFileUrl,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            gradient: context.brand.mainGradient,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: context.brand.mainGradient.colors.first
                    .withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPdf ? Icons.open_in_new_rounded : Icons.download_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                isPdf ? 'Buka PDF' : 'Unduh Gambar',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchFileUrl() async {
    await launchUrl(Uri.parse(fileUrl), mode: LaunchMode.externalApplication);
  }
}
