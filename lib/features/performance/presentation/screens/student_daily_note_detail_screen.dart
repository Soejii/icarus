import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/presentation/providers/student_note_detail_controller.dart';
import 'package:icarus/features/performance/presentation/widgets/attachment_preview_sheet.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/utils/date_helper.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class StudentDailyNoteDetailScreen extends ConsumerWidget {
  const StudentDailyNoteDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNote = ref.watch(studentNoteDetailControllerProvider(id));

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Detail Catatan',
        leadingIcon: true,
      ),
      body: asyncNote.when(
        data: (entity) => noteDetailBody(context, entity),
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () =>
              ref.invalidate(studentNoteDetailControllerProvider(id)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget noteDetailBody(BuildContext context, NoteEntity entity) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        noteCard(context, entity),
      ],
    );
  }

  Widget noteCard(BuildContext context, NoteEntity entity) {
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
                        formatIndoDate(entity.date ?? ''),
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
                  entity.note ?? '',
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
          if (entity.file != null) ...[
            Divider(height: 1.h, color: const Color.fromRGBO(0, 0, 0, 0.07)),
            attachmentRow(context, entity.file!),
          ],
        ],
      ),
    );
  }

  Widget attachmentRow(BuildContext context, String fileUrl) {
    final isPdf = fileUrl.toLowerCase().contains('.pdf') ||
        fileUrl.toLowerCase().contains('pdf');
    return GestureDetector(
      onTap: () => showAttachment(context, fileUrl),
      child: Container(
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
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                gradient: context.brand.mainGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lihat Lampiran',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: context.brand.mainGradient.colors.last,
                    ),
                  ),
                  Text(
                    isPdf ? 'Dokumen PDF' : 'Gambar',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 0, 0, 0.40),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color.fromRGBO(0, 0, 0, 0.30),
              size: 20.sp,
            ),
          ],
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
