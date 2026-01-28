import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/subject/presentation/providers/media_controller.dart';
import 'package:gaia/features/subject/presentation/widgets/media_card.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';

class MediaContentWidget extends ConsumerWidget {
  const MediaContentWidget({super.key, required this.idSubject});
  final int idSubject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncModule = ref.watch(mediaControllerProvider(idSubject));
    return asyncModule.when(
      data: (data) {
        if (data.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () => ref
                .read(mediaControllerProvider(idSubject).notifier)
                .refresh(idSubject),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              itemCount: data.length,
              itemBuilder: (context, index) => MediaCard(
                entity: data[index],
              ),
            ),
          );
        }
        return const DataNotFoundScreen(dataType: 'Learning Media');
      },
      error: (error, stackTrace) => BufferErrorView(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(mediaControllerProvider(idSubject)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
