import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/features/subject/presentation/providers/choose_subject_controller.dart';
import 'package:gaia/features/subject/presentation/widgets/quick_subject_button.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/screens/data_not_found_screen.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectPickerScreen extends ConsumerWidget {
  const SubjectPickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectAsnyc = ref.watch(chooseSubjectControllerProvider);

    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Pilih Mata Pelajaran',
        leadingIcon: true,
      ),
      body: subjectAsnyc.when(
        data: (data) {
          if (data.isEmpty) {
            return const DataNotFoundScreen(dataType: 'Mata Pelajaran');
          } else {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.w,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, index) => QuickSubjectButton(
                id: data[index].id,
                iconCode: data[index].iconCode,
                title: data[index].name ?? '-',
              ),
            );
          }
        },
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () => ref.invalidate(chooseSubjectControllerProvider),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
