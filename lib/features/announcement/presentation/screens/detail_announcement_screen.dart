import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/announcement/presentation/providers/detail_announcement_controller.dart';
import 'package:icarus/features/announcement/presentation/widgets/detail_announcement_content.dart';
import 'package:icarus/features/announcement/presentation/widgets/detail_announcement_image.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class DetailAnnouncementScreen extends ConsumerWidget {
  const DetailAnnouncementScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(detailAnnouncementControllerProvider(id));
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Detail Pengumuman',
        leadingIcon: true,
      ),
      body: detailAsync.when(
        data: (data) => ListView(
          children: [
            SizedBox(height: 30.h),
            DetailAnnouncementImage(
              imgUrl: data.photo,
            ),
            SizedBox(height: 20.h),
            DetailAnnouncementContent(
              title: data.title,
              date: data.date,
              desc: data.desc,
            ),
          ],
        ),
        error: (error, stackTrace) => BufferErrorView(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(detailAnnouncementControllerProvider(id)),
      ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
