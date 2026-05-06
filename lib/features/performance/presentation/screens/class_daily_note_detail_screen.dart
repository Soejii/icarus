import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/performance/domain/entities/class_note_detail_entity.dart';
import 'package:icarus/features/performance/presentation/providers/class_note_detail_controller.dart';
import 'package:icarus/features/performance/presentation/widgets/attachment_preview_sheet.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ClassDailyNoteDetailScreen extends ConsumerWidget {
  const ClassDailyNoteDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNote = ref.watch(classNoteDetailControllerProvider(id));

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Detail Catatan Kelas',
        leadingIcon: true,
      ),
      body: asyncNote.when(
        data: (entity) => noteDetailBody(context, entity),
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () => ref.invalidate(classNoteDetailControllerProvider(id)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget noteDetailBody(BuildContext context, ClassNoteDetailEntity entity) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        noteCard(context, entity),
      ],
    );
  }

  Widget noteCard(BuildContext context, ClassNoteDetailEntity entity) {
    final validFiles =
        entity.files.where((f) => f.file != null).toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (entity.title ?? '').toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.brand.textMain,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 14.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.40),
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        entity.teacherName ?? '-',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(0, 0, 0, 0.50),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.40),
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        entity.date ?? '-',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(0, 0, 0, 0.50),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  entity.notes ?? '',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                    color: const Color.fromRGBO(0, 0, 0, 0.80),
                  ),
                ),
              ],
            ),
          ),
          if (validFiles.isNotEmpty) ...[
            Divider(height: 1.h, color: const Color.fromRGBO(0, 0, 0, 0.07)),
            filesSection(context, validFiles),
          ],
        ],
      ),
    );
  }

  Widget filesSection(BuildContext context, List<ClassNoteFile> files) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
        gradient: LinearGradient(
          colors: [
            context.brand.mainGradient.colors.first.withOpacity(0.06),
            context.brand.mainGradient.colors.last.withOpacity(0.06),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_file,
                size: 14.sp,
                color: context.brand.mainGradient.colors.last,
              ),
              SizedBox(width: 4.w),
              Text(
                'Lampiran (${files.length})',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: context.brand.mainGradient.colors.last,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ...files.asMap().entries.map((e) => fileRow(context, e.key, e.value)),
        ],
      ),
    );
  }

  Widget fileRow(BuildContext context, int index, ClassNoteFile file) {
    final isPdf = file.file!.toLowerCase().contains('.pdf') ||
        file.file!.toLowerCase().contains('pdf');
    return Padding(
      padding: EdgeInsets.only(bottom: index < 0 ? 8.h : 0),
      child: GestureDetector(
        onTap: () => showAttachment(context, file.file!),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  gradient: context.brand.mainGradient,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  isPdf ? 'Dokumen PDF ${index + 1}' : 'Gambar ${index + 1}',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.brand.textMain,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: const Color.fromRGBO(0, 0, 0, 0.25),
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAttachment(BuildContext context, String fileUrl) {
    showDialog(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.75),
      builder: (_) => AttachmentPreviewSheet(fileUrl: fileUrl),
    );
  }
}
