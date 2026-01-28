import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icarus/features/announcement/presentation/providers/announcement_controller.dart';
import 'package:icarus/features/announcement/presentation/widgets/announcement_card.dart';
import 'package:icarus/shared/screens/buffer_error_view.dart';
import 'package:icarus/shared/screens/data_not_found_screen.dart';
import 'package:icarus/shared/widgets/custom_app_bar_widget.dart';

class ListAnnouncementScreen extends ConsumerWidget {
  const ListAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcementAsync = ref.watch(announcementControllerProvider);
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Pengumuman Sekolah',
        leadingIcon: true,
      ),
      body: announcementAsync.when(
        data: (data) {
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: AnnouncementCard(
                  entity: data[index],
                ),
              ),
            );
          } else {
            return const DataNotFoundScreen(dataType: 'Pengumuman');
          }
        },
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () => ref.invalidate(announcementControllerProvider),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
