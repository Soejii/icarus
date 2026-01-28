import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaia/app/theme/brand_palette.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';
import 'package:gaia/features/school/presentation/providers/school_controller.dart';
import 'package:gaia/features/school/presentation/widgets/school_information_content.dart';

class SchoolInformationScreen extends ConsumerWidget {
  const SchoolInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolAsync = ref.watch(schoolControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Informasi Sekolah',
        leadingIcon: true,
      ),
      body: schoolAsync.when(
        data: (school) => SchoolInformationContent(school: school),
        loading: () => Center(
      child: CircularProgressIndicator(
        color: context.brand.primary,
      ),
    ),
        error: (error, stack) => BufferErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(schoolControllerProvider),
        ),
      ),
    );
  }
}
