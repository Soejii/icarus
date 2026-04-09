import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';

class AbsenceLetterActionSheetWidget extends StatelessWidget {
  const AbsenceLetterActionSheetWidget({
    super.key,
    required this.isEditable,
    required this.onViewAttachment,
    required this.onEdit,
    required this.onDelete,
  });

  final bool isEditable;
  final VoidCallback onViewAttachment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.brand.inactive,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 8.h),
          sheetOption(
            context,
            label: 'Lihat Lampiran',
            color: context.brand.primary,
            onTap: onViewAttachment,
          ),
          Divider(height: 1.h, color: context.brand.inactive.withOpacity(0.3)),
          sheetOption(
            context,
            label: 'Edit',
            color: isEditable ? context.brand.primary : context.brand.inactive,
            onTap: isEditable ? onEdit : null,
          ),
          Divider(height: 1.h, color: context.brand.inactive.withOpacity(0.3)),
          sheetOption(
            context,
            label: 'Hapus',
            color: isEditable ? Colors.red : context.brand.inactive,
            onTap: isEditable ? onDelete : null,
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  sheetOption(
    BuildContext context, {
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}
