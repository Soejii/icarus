import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/core/constant/app_colors.dart';

class ChildDocumentFormWidget extends ConsumerStatefulWidget {
  final bool readOnly;

  const ChildDocumentFormWidget({super.key, this.readOnly = false});

  @override
  ConsumerState<ChildDocumentFormWidget> createState() =>
      _ChildDocumentFormWidgetState();
}

class _ChildDocumentFormWidgetState
    extends ConsumerState<ChildDocumentFormWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  static const _imageDocuments = [
    'Pas Foto',
    'Foto Badan Penuh',
    'Kartu Keluarga',
  ];

  static const _pdfDocuments = [
    'Ijazah',
    'NISN/Kartu Pelajar',
    'Akta Kelahiran',
    'Lampiran/Assesmen Kebutuhan Khusus',
    'Bukti Prestasi',
  ];

  sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.brand.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  documentUploadSlot({
    required String label,
    required bool isImage,
    bool hasFile = false,
  }) {
    final isReadOnly = widget.readOnly;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: context.brand.textMain,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            hasFile ? 'File saat ini :' : 'Belum ada file',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: context.brand.textSecondary,
              fontStyle: hasFile ? FontStyle.normal : FontStyle.italic,
            ),
          ),
          if (hasFile) ...[
            SizedBox(height: 8.h),
            Icon(
              isImage ? Icons.image_outlined : Icons.picture_as_pdf,
              size: 24.sp,
              color: context.brand.primary,
            ),
          ],
          if (!isReadOnly) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  isImage ? Icons.camera_alt : Icons.picture_as_pdf,
                  size: 20.sp,
                  color: isImage
                      ? context.brand.textSecondary
                      : AppColors.danger,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Pilih file untuk $label',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.brand.inactive.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        hasFile ? 'Ganti file' : 'Pilih file',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: context.brand.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      children: [
        sectionCard('Dokumen', [
          ..._imageDocuments.map(
            (doc) => documentUploadSlot(
              label: doc,
              isImage: true,
              hasFile: true,
            ),
          ),
          ..._pdfDocuments.map(
            (doc) => documentUploadSlot(
              label: doc,
              isImage: false,
              hasFile: false,
            ),
          ),
        ]),
        SizedBox(height: 32.h),
      ],
    );
  }
}
