import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/app/theme/brand_palette.dart';
import 'package:icarus/features/performance/domain/entities/note_entity.dart';
import 'package:icarus/features/performance/presentation/providers/student_note_detail_controller.dart';
import 'package:icarus/features/performance/presentation/widgets/attachment_preview_sheet.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
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
          onRetry: () => ref.invalidate(studentNoteDetailControllerProvider(id)),
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  (entity.title ?? '').toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.brand.textMain,
                  ),
                ),
              ),
              if (entity.file != null)
                GestureDetector(
                  onTap: () => showAttachment(context, entity.file!),
                  child: Icon(
                    Icons.insert_drive_file_outlined,
                    size: 24.sp,
                    color: context.brand.textSecondary,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 14.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.50),
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
                color: const Color.fromRGBO(0, 0, 0, 0.50),
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
            entity.note ?? '',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(0, 0, 0, 0.80),
            ),
          ),
        ],
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
