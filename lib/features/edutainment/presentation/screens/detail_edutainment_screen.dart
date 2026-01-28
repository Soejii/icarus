import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaia/features/edutainment/presentation/providers/detail_edutainment_controller.dart';
import 'package:gaia/features/edutainment/presentation/widgets/detail_edutainment_content.dart';
import 'package:gaia/features/edutainment/presentation/widgets/detail_edutainment_image.dart';
import 'package:gaia/shared/screens/buffer_error_view.dart';
import 'package:gaia/shared/widgets/custom_app_bar_widget.dart';

class DetailEdutainmentScreen extends ConsumerWidget {
  const DetailEdutainmentScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(detailEdutainmentControllerProvider(id));
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Detail Edutainment',
        leadingIcon: true,
      ),
      body: detailAsync.when(
        data: (data) => ListView(
          children: [
            SizedBox(height: 30.h),
            DetailEdutainmentImage(
              imgUrl: data.photo,
            ),
            SizedBox(height: 20.h),
            DetailEdutainmentContent(
              title: data.title,
              date: data.date,
              desc: data.desc,
              link: data.link,
            ),
          ],
        ),
        error: (error, stackTrace) => BufferErrorView(
          error: error,
          stackTrace: stackTrace,
          onRetry: () =>
              ref.invalidate(detailEdutainmentControllerProvider(id)),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
