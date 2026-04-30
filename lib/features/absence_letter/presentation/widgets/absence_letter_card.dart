import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/absence_letter/domain/entities/absence_letter_entity.dart';
import 'package:icarus/features/absence_letter/presentation/widgets/absence_letter_action_sheet_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AbsenceLetterCard extends StatelessWidget {
  const AbsenceLetterCard({super.key, required this.entity});

  final AbsenceLetterEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: context.brand.textSecondary,
                        size: 20.r,
                      ),
                      onPressed: () => showOptions(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ],
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

  void showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetCtx) => AbsenceLetterActionSheetWidget(
        isEditable: entity.isEditable,
        hasAttachment: entity.evidencePath != null,
        onViewAttachment: () {
          Navigator.pop(sheetCtx);
          viewAttachment(context);
        },
        onEdit: () {
          Navigator.pop(sheetCtx);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit surat izin belum tersedia')),
          );
        },
        onDelete: () {
          Navigator.pop(sheetCtx);
          showDeleteDialog(context);
        },
      ),
    );
  }

  Future<void> viewAttachment(BuildContext context) async {
    final evidencePath = entity.evidencePath;
    if (evidencePath == null) return;
    final uri = Uri.tryParse(evidencePath);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lampiran tidak dapat dibuka')),
      );
    }
  }

  void showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        title: Text(
          'Konfirmasi Hapus',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.brand.textSecondary,
          ),
        ),
        content: Text(
          'Apakah anda yakin ingin menghapus surat izin ini?',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 12.sp,
            color: context.brand.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(
              'Batal',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: context.brand.inactive,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(
              'Hapus',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
