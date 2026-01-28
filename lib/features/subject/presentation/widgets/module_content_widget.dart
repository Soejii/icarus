import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/subject/presentation/providers/module_controller.dart';
import 'package:gaia/features/subject/presentation/widgets/module_card.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModuleContentWidget extends ConsumerWidget {
  const ModuleContentWidget({super.key, required this.idSubject});
  final int idSubject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncModule = ref.watch(moduleControllerProvider(idSubject));
    return asyncModule.when(
      data: (data) {
        if (data.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () => ref
                .read(moduleControllerProvider(idSubject).notifier)
                .refresh(idSubject),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              itemCount: data.length,
              itemBuilder: (context, index) => ModuleCard(
                entity: data[index],
              ),
            ),
          );
        }
        return const DataNotFoundScreen(dataType: 'Modul');
      },
      error: (error, stackTrace) => BufferErrorView(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(moduleControllerProvider(idSubject)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
