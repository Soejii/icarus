import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/shared/widgets/gradient_text.dart';
import 'package:image_picker/image_picker.dart';

class CreateAbsenceLetterFormWidget extends HookWidget {
  const CreateAbsenceLetterFormWidget({
    super.key,
    this.initialReason = 'Sakit',
    this.initialNotes = '',
    this.initialStartDate,
    this.initialEndDate,
    this.studentName = 'M. Khazil',
    this.studentClass = 'XII - RPL 1',
  });

  final String initialReason;
  final String initialNotes;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final String studentName;
  final String studentClass;

  @override
  Widget build(BuildContext context) {
    final selectedReason = useState(initialReason);
    final notesController = useTextEditingController(text: initialNotes);
    final startDate = useState<DateTime?>(initialStartDate);
    final endDate = useState<DateTime?>(initialEndDate);
    final pickedFile = useState<XFile?>(null);

    return ColoredBox(
      color: Colors.grey.shade50,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            studentInfoCard(context),
            SizedBox(height: 12.h),
            sectionCard(
              context,
              title: 'Alasan tidak hadir',
              child: reasonToggle(context, selectedReason),
            ),
            SizedBox(height: 12.h),
            sectionCard(
              context,
              title: 'Keterangan',
              child: notesField(context, notesController),
            ),
            SizedBox(height: 12.h),
            sectionCard(
              context,
              title: 'Periode Tidak Hadir',
              child: dateRangeRow(context, startDate, endDate),
            ),
            SizedBox(height: 12.h),
            sectionCard(
              context,
              title: 'Lampiran dokumen pendukung*',
              child: attachmentArea(context, pickedFile),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  studentInfoCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.brand.mainGradient,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              Icons.person_outline_rounded,
              color: Colors.white,
              size: 24.r,
            ),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                studentName,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                studentClass,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.school_outlined,
            color: Colors.white.withOpacity(0.6),
            size: 20.r,
          ),
        ],
      ),
    );
  }

  sectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: context.brand.shadow,
      ),
      padding: EdgeInsets.all(16.w),
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
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }

  reasonToggle(BuildContext context, ValueNotifier<String> selectedReason) {
    return Row(
      children: [
        reasonPill(context, label: 'Sakit', selectedReason: selectedReason),
        SizedBox(width: 10.w),
        reasonPill(context, label: 'Izin', selectedReason: selectedReason),
      ],
    );
  }

  reasonPill(
    BuildContext context, {
    required String label,
    required ValueNotifier<String> selectedReason,
  }) {
    final isSelected = selectedReason.value == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => selectedReason.value = label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            gradient: isSelected ? context.brand.mainGradient : null,
            border: isSelected
                ? null
                : Border.all(color: context.brand.primary),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: isSelected
                ? Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                : GradientText(
                    label,
                    gradient: context.brand.mainGradient,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  notesField(BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 4,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 13.sp,
        color: context.brand.textMain,
      ),
      decoration: InputDecoration(
        hintText: 'Tuliskan keterangan di sini...',
        hintStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 13.sp,
          color: context.brand.inactive,
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: context.brand.inactive.withOpacity(0.4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: context.brand.inactive.withOpacity(0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: context.brand.primary, width: 1.5),
        ),
      ),
    );
  }

  dateRangeRow(
    BuildContext context,
    ValueNotifier<DateTime?> startDate,
    ValueNotifier<DateTime?> endDate,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mulai tanggal',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 11.sp,
                  color: context.brand.inactive,
                ),
              ),
              SizedBox(height: 6.h),
              datePillButton(context, startDate),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 18.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Icon(
              Icons.arrow_forward,
              size: 16.r,
              color: context.brand.inactive,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sampai tanggal',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 11.sp,
                  color: context.brand.inactive,
                ),
              ),
              SizedBox(height: 6.h),
              datePillButton(context, endDate),
            ],
          ),
        ),
      ],
    );
  }

  datePillButton(BuildContext context, ValueNotifier<DateTime?> dateNotifier) {
    final label = dateNotifier.value != null
        ? '${dateNotifier.value!.day.toString().padLeft(2, '0')}/'
            '${dateNotifier.value!.month.toString().padLeft(2, '0')}/'
            '${dateNotifier.value!.year}'
        : 'DD/MM/YYYY';
    final hasValue = dateNotifier.value != null;

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: dateNotifier.value ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) dateNotifier.value = picked;
      },
      child: Container(
        padding: EdgeInsets.all(2.5.r),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: hasValue
                ? context.brand.primary
                : context.brand.inactive.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: context.brand.shadow,
        ),
        child: Row(
          children: [
            Container(
              width: 34.r,
              height: 34.r,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                borderRadius: BorderRadius.circular(17.r),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
                size: 15.r,
              ),
            ),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 11.sp,
                  fontWeight:
                      hasValue ? FontWeight.w600 : FontWeight.w400,
                  color: hasValue
                      ? context.brand.textMain
                      : context.brand.inactive,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  attachmentArea(BuildContext context, ValueNotifier<XFile?> pickedFile) {
    if (pickedFile.value != null) {
      return pickedFilePreview(context, pickedFile);
    }

    return GestureDetector(
      onTap: () => showPickerSheet(context, pickedFile),
      child: DashedBorderContainer(
        child: Column(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.attach_file_rounded,
                color: Colors.white,
                size: 20.r,
              ),
            ),
            SizedBox(height: 8.h),
            GradientText(
              'Lampirkan file disini',
              gradient: context.brand.mainGradient,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Ambil foto atau pilih dari galeri',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 11.sp,
                color: context.brand.inactive,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickedFilePreview(BuildContext context, ValueNotifier<XFile?> pickedFile) {
    final file = pickedFile.value!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.brand.primary.withOpacity(0.4)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Stack(
          children: [
            Image.file(
              File(file.path),
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Row(
                children: [
                  changeButton(context, pickedFile),
                  SizedBox(width: 6.w),
                  removeButton(context, pickedFile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeButton(BuildContext context, ValueNotifier<XFile?> pickedFile) {
    return GestureDetector(
      onTap: () => showPickerSheet(context, pickedFile),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'Ganti',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  removeButton(BuildContext context, ValueNotifier<XFile?> pickedFile) {
    return GestureDetector(
      onTap: () => pickedFile.value = null,
      child: Container(
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(Icons.close, color: Colors.white, size: 14.r),
      ),
    );
  }

  void showPickerSheet(BuildContext context, ValueNotifier<XFile?> pickedFile) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetCtx) => SafeArea(
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
            ListTile(
              leading: Icon(Icons.camera_alt_outlined, color: context.brand.primary),
              title: Text(
                'Ambil foto',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
              onTap: () async {
                Navigator.pop(sheetCtx);
                final picked = await ImagePicker()
                    .pickImage(source: ImageSource.camera);
                if (picked != null) pickedFile.value = picked;
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined, color: context.brand.primary),
              title: Text(
                'Pilih dari galeri',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.textMain,
                ),
              ),
              onTap: () async {
                Navigator.pop(sheetCtx);
                final picked = await ImagePicker()
                    .pickImage(source: ImageSource.gallery);
                if (picked != null) pickedFile.value = picked;
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

class DashedBorderContainer extends StatelessWidget {
  const DashedBorderContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: context.brand.primary),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(child: child),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    const radius = Radius.circular(12);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      radius,
    );

    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final extracted = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extracted, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color;
}
